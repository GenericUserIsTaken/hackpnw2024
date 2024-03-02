extends Node2D

@export var traced: Array = []
var lines : 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addTrace(NewTask : Task):
	traced.push_front(NewTask)

func removeTrace(DeadTask : Task):
	for i in range(len(traced)):
		if traced[i] == DeadTask:
			traced.remove_at(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
