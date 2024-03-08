extends Area2D

var mousePos = Vector2()
var mouseClicked = false

var enterPos = null
var exitPos = null

var deleteMode = false

var newTaskNode = preload("res://scenes/TASK/task_node.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enterPos != null and exitPos != null:
		print("sliced!")
		enterPos = null
		exitPos = null
		
		# if delete mode, delete self, otherwise make a new node
		if deleteMode:
			self.get_parent().queue_free()
		else:
			#$"../Node2D/TextEdit".visible = true
			var new_task = newTaskNode.instantiate()
			self.get_parent().get_parent().add_child(new_task)
			new_task.position = self.get_parent().position
			new_task.parentTask = self.get_parent()

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		mouseClicked = event.pressed
		if !mouseClicked:
			enterPos = null
			exitPos = null
	elif event is InputEventMouseMotion:
		mousePos = event.position
	elif event.pressed and event.keycode == KEY_D:
			deleteMode = !deleteMode

func _on_mouse_entered():
	if mouseClicked:
		enterPos = mousePos

func _on_mouse_exited():
	if mouseClicked:
		exitPos = mousePos
