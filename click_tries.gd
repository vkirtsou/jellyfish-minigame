extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var imgCorrect = load("res://temp/try_correct.png")
var imgWrong = load("res://temp/try_wrong.png")

func _ready():
	pass
	
func mark_try_as_wrong(try):			
	var to_mark = get_node("VBoxContainer").get_child(try)
	to_mark.set_texture(imgWrong)

func mark_try_as_correct(try):
	var to_mark = get_node("VBoxContainer").get_child(try)
	to_mark.set_texture(imgCorrect)
	pass