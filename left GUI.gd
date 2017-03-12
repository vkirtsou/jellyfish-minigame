extends Node

var button_back
var shell_button
var pause_button
var kalulu_button

var buttons

func _ready():
	
	button_back = get_node("OuterBox/button_back")
	shell_button = get_node("OuterBox/InnerBox/shell_button")
	pause_button = get_node("OuterBox/InnerBox/pause_button")
	kalulu_button = get_node("OuterBox/kalulu_button")
	button_back.connect("pressed", self, "_on_shell_button_pressed")
	pause_button.connect("pressed", self, "_on_pause_button_pressed")
	
func _on_shell_button_pressed():
	var back_popup_scene = load("res://back_dialog_window.tscn")
	var back_popup = back_popup_scene.instance()
	add_child(back_popup)
	game_manager.pause_game(true)
	
func _on_pause_button_pressed():
	var pause_popup_scene = load("res://pause_dialog_window.tscn")
	var pause_popup = pause_popup_scene.instance()
	add_child(pause_popup)
	game_manager.pause_game(true)