extends RigidBody2D

class_name Task
@export var children: Array = []
@export var parentTask: Task
@export var taskname: String = "TextName"
@export var nearbyTasks: Dictionary = {}

# an extra multiplier on push to others
@export var pushWeight: float = 1

# should be <= collider radius
@export var maxDistanceForPush: float = 250

@export var distanceToForceBaseMultiplier: float = 1

@export var parentPullMultiplier: float = 0.7

# tracks other tasks within push distance
var otherTasks

var parentForce = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	# temporary random names to help tell them apart
	var names = ["amogus","sussy","goduh",":3","nah","ayo wtf","uwu","top ten","task: pet maxwell"]
	self.changeTaskName(names.pick_random())

func changeTaskName(newName : String):
	$CenterContainer/Label.text = newName
	taskname = newName

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
	diffVector = diffVector.normalized() * max(0, maxDistanceForPush - diffVector.length())
	diffVector *= distanceToForceBaseMultiplier
	diffVector *= otherTask.get_parent().pushWeight
	return diffVector

func calc_pull_to_parent():
	var diffVector = (parentTask.global_position - self.global_position)
	diffVector *= parentPullMultiplier
	diffVector *= distanceToForceBaseMultiplier
	diffVector *= parentTask.pushWeight
	return diffVector

func _draw():
	for otherTask in otherTasks:
		draw_line(Vector2(0,0), 4*calc_push_from(otherTask), Color.GREEN, 4.0)
	draw_line(Vector2(0,0), 4*parentForce, Color.RED, 4.0)
