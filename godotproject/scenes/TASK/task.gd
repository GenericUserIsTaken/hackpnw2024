extends RigidBody2D

class_name Task
@export var parentTask: Task
@export var taskname: String = "TextName"

# motion of the task
var velo = Vector2()
var maxVelo = 0
var accel = Vector2()
@export var friction: float = 0

# multiplier for all the ranges. should be between 0 and 1
@export var taskSize: float = 1

# motion ranges and multipliers
var allPushRange = 500
var allPushMultiplier = 1

var parentPushRange = 150
var parentPushMultiplier = 20

# no range, always applied
var parentPullMultiplier = 20

# tracks other tasks within range distance
var otherTasks

var parentForce = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	# temporary random names to help tell them apart
	var names = ["amogus","sussy","goduh",":3","nah","ayo wtf","uwu","top ten","task: pet maxwell"]
	self.changeTaskName(names.pick_random())
	
	# change push ranges based on task size
	allPushRange *= taskSize
	parentPushRange *= taskSize
	
	#self.rigidbody2d.set_linear_damp(friction)
	
	#$Area2D/NearbyCollider

func changeTaskName(newName : String):
	#$CenterContainer/Label.text = newName
	taskname = newName

# handles the motion of the tasknode
func _integrate_forces(state : PhysicsDirectBodyState2D):
	# get all the overlapping areas
	otherTasks = $Area2D.get_overlapping_areas()
	
	# calculate incoming acceleration
	# push from all:
	accel = Vector2()
	for otherTask in otherTasks:
		var diffVector = self.global_position - otherTask.global_position
		accel += diffVector.normalized() * max(0, otherTask.get_parent().allPushRange - diffVector.length()) * allPushMultiplier
	# if has a parent, apply linking forces
	if parentTask != null:
		var diffVector = self.global_position - parentTask.global_position
		# pull from parent:
		accel -= diffVector * parentPullMultiplier
		# push from parent:
		accel += diffVector.normalized() * max(0, parentTask.parentPushRange - diffVector.length()) * parentPushMultiplier
	
	# calculate next velocity using acceleration
	velo += accel
	if velo.length() <= friction:
		velo = Vector2()
	else:
		velo = velo.normalize() * (velo.length() - friction)
	
	# apply velocity
	state.set_linear_velocity(velo)
	queue_redraw()

"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	otherTasks = $Area2D.get_overlapping_areas()
	for otherTask in otherTasks:
		self.apply_central_force(calc_push_from(otherTask))
	if (parentTask != null):
		parentForce = calc_pull_to_parent()
		self.apply_central_force(parentForce)
	
	queue_redraw()

func calc_push_from(otherTask):
	var diffVector = (self.global_position - otherTask.global_position)
	diffVector = diffVector.normalized() * max(0, otherTask.get_parent().maxDistanceForPush - diffVector.length())
	diffVector *= distanceToForceBaseMultiplier * (1 - pushResistance)
	diffVector *= otherTask.get_parent().pushWeight
	return diffVector

func calc_pull_to_parent():
	var diffVector = (parentTask.global_position - self.global_position)
	diffVector *= parentPullMultiplier * distanceToForceBaseMultiplier
	diffVector *= parentTask.pushWeight
	return diffVector
"""

func _draw():
	# draw lines to parent
	if parentTask != null:
		draw_line(Vector2(0,0), self.to_local(parentTask.global_position), Color.BLACK, 10.0)
		
	# draw velo and accel debug
	draw_line(Vector2(0,0), velo, Color.BLUE, 4.0)
	draw_line(Vector2(0,0), accel, Color.GREEN, 4.0)
