extends Control
signal doit()
signal changec(color)

@onready var colorguy = $Control2/HBoxContainer/Control2/Panel/VBoxContainer/Control7/HBoxContainer/MarginContainer/AspectRatioContainer/ColorPicker
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	doit.emit()


func _on_colorbutton_button_down():
	var newcolor = colorguy.color
	changec.emit(newcolor)
