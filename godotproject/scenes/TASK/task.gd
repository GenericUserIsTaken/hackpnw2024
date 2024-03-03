extends RigidBody2D

class_name TaskNode
@export var parentTask: TaskNode
@export var taskname: String = "TextName"

# motion of the task
var velo = Vector2()
var maxVelo = 300
var accel = Vector2()
@export var friction: float = 1
@export var frictionCurve: float = 0.1

# multiplier for all the ranges. should be between 0 and 1
@export var taskSize: float = 1

# motion ranges and multipliers
var allPushRange = 500
var allPushMultiplier = 6

var parentPushRange = 250
var parentPushMultiplier = 4

# no range, always applied
var parentPullMultiplier = 20

# tracks other tasks within range distance
var otherTasks

var parentForce = Vector2(0,0)

@onready var isReady = $Area2D
@onready var replacetex = load("res://resources/hexagon.png")
@onready var textedit = $Node2D/TextEdit
@onready var mysprite = $Sprite2D

var description : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# temporary random names to help tell them apart
	#var names = [""amogus","sussy","goduh",":3","nah","ayo wtf","uwu","top ten","task: pet maxwell"ex"]
	#self.changeTaskName(names.pick_random())
	self.changeTaskName("Task")
	
	# change push ranges based on task size
	allPushRange *= taskSize
	parentPushRange *= 2 * taskSize
	
	#self.rigidbody2d.set_linear_damp(friction)
	
	#$Area2D/NearbyCollider

func changeTaskName(newName : String):
	$CenterContainer/Label.text = newName
	taskname = newName

# handles the motion of the tasknode
func _integrate_forces(state : PhysicsDirectBodyState2D):
	if isReady:
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
		velo += 0.01 * accel
		if velo.length() <= friction:
			velo = Vector2()
		else:
			velo = velo.normalized() * min(velo.length() * (1 - frictionCurve) - friction, maxVelo)
		
		# apply velocity
		state.set_linear_velocity(velo)
		queue_redraw()


func _draw():
	# draw lines to parent
	if parentTask != null:
		draw_line(Vector2(0,0), self.to_local(parentTask.global_position), Color.BLACK, 10.0)
		
	# draw velo and accel debug
	#draw_line(Vector2(0,0), 2*velo, Color.BLUE, 4.0)
	#draw_line(Vector2(0,0), 0.5*accel, Color.GREEN, 4.0)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			var mouse_position = event.position
			textedit.visible = true


func _on_text_edit_submit(newname, newdesc):
	changeTaskName(newname)
	description = newdesc
	textedit.visible = false
	
func changetexture():
	mysprite.texture = replacetex
	
func changecolor(color):
	mysprite.changecolor(color)
