extends RigidBody2D

class_name Task
@export var children: Array = []
@export var parent: Task
@export var taskname: String = "TextName"
@export var nearbyTasks: Dictionary = {}

@export var maxDistanceForPush: int = 5
@export var distanceToForceBaseMultiplier: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func changeTaskName(newName : String):
	$Label.text = newName
	taskname = newName

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for otherTask in nearbyTasks:
		var diffVector = (self.position - otherTask.position)
		diffVector = diffVector.normalized() * max(0, diffVector.length() - maxDistanceForPush)
		self.apply_central_force(diffVector * distanceToForceBaseMultiplier)


func _on_area_2d_area_entered(area):
	if (area.parent != self):
		nearbyTasks.update[area.parent] = null


func _on_area_2d_area_exited(area):
	nearbyTasks.erase(area.parent)
