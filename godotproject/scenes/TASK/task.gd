extends RigidBody2D

class_name Task
@export var children: Array = []
@export var parent: Task
@export var taskname: String = "TextName"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func changeTaskName(newName : String):
	$Label.text = newName
	taskname = newName

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
