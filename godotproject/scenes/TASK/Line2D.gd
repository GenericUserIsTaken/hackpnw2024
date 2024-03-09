extends Line2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	add_point(get_global_mouse_position())
	remove_point(0)
