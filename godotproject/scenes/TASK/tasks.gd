extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shop_doit():
	for i in self.get_children():
		i.changetexture()


func _on_shop_changec(color):
	for i in self.get_children():
		i.changecolor(color)
