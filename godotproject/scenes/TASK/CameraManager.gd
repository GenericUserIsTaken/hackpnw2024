extends Camera2D

@export var followerTarget: TaskNode

var isFollowingTarget = true
# 0 < speed <= 1
var followSpeed = 0.05

var targetPos = Vector2()

var mouse_button_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		mouse_button_down = event.is_pressed()
   #elif event is InputEventMouseMotion:
	   #print("Mouse Motion at: ", event.position)

   # Print the size of the viewport.
   #print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isFollowingTarget and followerTarget != null:
		targetPos = followerTarget.global_position
	self.position += (targetPos - self.global_position) * followSpeed
