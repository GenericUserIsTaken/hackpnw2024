extends Control
signal NameChanged(newname : String)
signal DescriptionChanged(newdesc : String)
signal Submit(newname : String, newdesc : String)
@onready var description = $AspectRatioContainer/Panel/MarginContainer2/Panel2/MarginContainer/DescriptionEdit
@onready var nametxt = $AspectRatioContainer/Panel/MarginContainer/Panel/MarginContainer/NameEdit
@export var desclimit = 10
@export var namelimit = 10

var current_text1 = ""
var current_text2 = ""
var cursor_line1 = 0
var cursor_column1 = 0
var cursor_line2 = 0
var cursor_column2 = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_description_edit_text_changed():
	var new_text : String = description.text
	var enter = new_text.contains("\n")
	if new_text.length() > desclimit or enter:
		description.text = current_text1
		description.set_caret_line(cursor_line1)
		description.set_caret_column(cursor_column1)
	current_text1 = description.text
	# save current position of cursor for when we have reached the limit
	cursor_line1 = description.get_caret_line()
	cursor_column1 = description.get_caret_column()
	
func _on_name_edit_text_changed():
	var new_text : String = nametxt.text
	var enter = new_text.contains("\n")
	if new_text.length() > namelimit or enter:
		nametxt.text = current_text2
		nametxt.set_caret_line(cursor_line2)
		nametxt.set_caret_column(cursor_column2)
	current_text2 = nametxt.text
	# save current position of cursor for when we have reached the limit
	cursor_line2 = nametxt.get_caret_line()
	cursor_column2 = nametxt.get_caret_column()


func _on_button_button_down():
	DescriptionChanged.emit(description.text)
	NameChanged.emit(nametxt.text)
	Submit.emit(nametxt.text,description.text)
