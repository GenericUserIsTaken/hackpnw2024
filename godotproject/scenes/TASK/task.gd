extends RigidBody2D

class_name Task
@export var children: Array = []
@export var parent: Task
@export var taskname: String = "TextName"
@export var nearbyTasks: Dictionary = {}

@export var pushWeight: float = 1

@export var maxDistanceForPush: float = 250
@export var distanceToForceBaseMultiplier: float = 1
var otherTasks

# Called when the node enters the scene tree for the first time.
func _ready():
	var names = ["amogus","sussy","goduh","nah","ayo wtf","top ten","task: pet maxwell"]
	self.changeTaskName(names.pick_random())

func changeTaskName(newName : String):
	#if $Label != null:
	$CenterContainer/Label.text = newName
	taskname = newName

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	otherTasks = $Area2D.get_overlapping_areas()
	for otherTask in otherTasks:
		var diffVector = (self.global_position - otherTask.global_position)
		diffVector = diffVector.normalized() * max(0, maxDistanceForPush - diffVector.length())
		self.apply_central_force(diffVector * distanceToForceBaseMultiplier)
	queue_redraw()

func _draw():
	for otherTask in otherTasks:
		var diffVector = (self.global_position - otherTask.global_position)
		diffVector = diffVector.normalized() * max(0, maxDistanceForPush - diffVector.length())
		draw_line(Vector2(0,0), 4*diffVector, Color.GREEN, 4.0)
