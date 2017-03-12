extends Node

var button_back
var shell_button
var pause_button
var kalulu_button

func _ready():
	
	button_back = get_node("OuterBox/button_back")
	shell_button = get_node("OuterBox/InnerBox/shell_button")
	pause_button = get_node("OuterBox/InnerBox/pause_button")
	kalulu_button = get_node("OuterBox/kalulu_button")
	button_back.connect("pressed", self, "_on_back_button_pressed")
	shell_button.connect("pressed", self, "_on_shell_button_pressed")
	pause_button.connect("pressed", self, "_on_pause_button_pressed")
	kalulu_button.connect("pressed", self, "_on_kalulu_button_pressed")

func _on_back_button_pressed():				# back button: instantiate the popup scene
	var back_popup_scene = preload("res://back_dialog_window.tscn")
	var back_popup = back_popup_scene.instance()
	add_child(back_popup)
	game_manager.pause_game(true)
	
func _on_shell_button_pressed():			# shell button: play the sound
	#play current phonetic
	shell_button.get_node("phoneticPlayer").play("phoneme_o", false);
	
func _on_pause_button_pressed():			# pause button: instatiate the pause scene
	var pause_popup_scene = preload("res://pause_dialog_window.tscn")
	var pause_popup = pause_popup_scene.instance()
	add_child(pause_popup)
	game_manager.pause_game(true)
	
func _on_kalulu_button_pressed():			
	var kalulu_scene = game_manager.get_kalulu_scene()
	var kalulu = kalulu_scene.instance()
	add_child(kalulu)
	game_manager.pause_game(true)
	kalulu.help()
	
func hide_kalulu_button():
	get_node("OuterBox/kalulu_button").set_opacity(0)
	