extends RigidBody2D

class_name Task
@export var children: Array = []
@export var parent: Task
@export var taskname: String = "TextName"
@export var nearbyTasks: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func changeTaskName(newName : String):
	$Label.text = newName
	taskname = newName

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if (area.parent != self):
		nearbyTasks.append(area.parent)


func _on_area_2d_area_exited(area):
	pass # Replace with function body.
