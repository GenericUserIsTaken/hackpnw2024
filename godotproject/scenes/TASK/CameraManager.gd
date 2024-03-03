extends Camera2D

@export var followerTarget: Task

var isFollowingTarget = true
# 0 < speed <= 1
var followSpeed = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isFollowingTarget and followerTarget != null:
		self.position += (followerTarget.position - self.position) * followSpeed
