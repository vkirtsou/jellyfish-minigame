extends Control

var scale
var pos

func _ready():
	var size = get_node("Shell_button_big").get_size()
	var viewport_size = get_viewport_rect().size
	game_manager.pause_game(true)
	get_node("Shell_button_big").connect("pressed", self, "_on_Shell_button_big_pressed")
	var small_shell = get_tree().get_current_scene().get_node("HBoxContainer/Control/OuterBox/InnerBox/shell_button")
	scale = small_shell.get_scale()
	pos = small_shell.get_global_pos()
	
func _on_Shell_button_big_pressed():
	get_node("shell_animator").get_animation("shell_zoomout").track_set_key_value(0, 1, pos)
	get_node("Shell_button_big").set_disabled(true)
	get_node("shell_animator").play("shell_zoomout")			#play the animation
	get_node("phoneticPlayer").play("phoneme_o", true);			#play the phonetic
	yield(get_node("shell_animator"), "finished")				# wait until the animation is finished
	game_manager.pause_game(false)								# Unpause the game
	queue_free()												# delete the scene
	