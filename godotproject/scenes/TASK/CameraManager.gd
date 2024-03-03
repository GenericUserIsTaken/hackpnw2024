extends Camera2D

@export var followedNode: TaskNode

var isFollowingNode = true
# 0 < speed <= 1
var followNodeSpeed = 0.5
var followTargetSpeed = 1
# gets set to speeds depending on follow state:
var followSpeed

var targetPos = Vector2()

var spaceDown = false
var prevMousePos = Vector2()
var mouseDelta = Vector2()
var scrollDelta = 0
var scrollSpeed = 1
var zoomTarget = 1
var zoomSpeed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			scrollDelta = scrollSpeed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			scrollDelta = -scrollSpeed
	elif event is InputEventMouseMotion:
		mouseDelta = event.position - prevMousePos
		prevMousePos = event.position
	elif event.pressed and event.keycode == KEY_H:
		isFollowingNode = true
		zoomTarget = 1
	elif event.keycode == KEY_SPACE:
		spaceDown = event.pressed
		isFollowingNode = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spaceDown:
		targetPos -= mouseDelta / zoomTarget
		mouseDelta = Vector2()
		followSpeed = followTargetSpeed
	elif isFollowingNode and followedNode != null:
		targetPos = followedNode.global_position
		followSpeed = followNodeSpeed
	else:
		followSpeed = 0
	self.position += (targetPos - self.global_position) * followSpeed
	
	zoomTarget = limit(zoomTarget + 0.1 * scrollDelta, 0.2, 4)
	zoom += (zoomTarget * Vector2(1,1) - zoom) * zoomSpeed
	scrollDelta = 0

func limit(val, min, max):
	return max(min, min(max, val))
