extends Node

var jellies_to_catch = 4
var i = 0
var kalulu_scene
var is_level_complete

func _ready():
	kalulu_scene = preload("res://Kalulu_ctrl.tscn")			#had to preload because it takes a lot of time to load due to image errors
	is_level_complete = false
	
func click_tries():
	print("clicked!")
	i = i + 1
	if (i == jellies_to_catch):
		#game_over()
		pass
		
func pause_game(someBool):
	get_tree().set_pause(someBool)				# pause the game
	if (get_tree().get_current_scene().get_name() == "mainCtrl"):
		var tint = get_tree().get_root().get_child(1).get_node("tint")
		if someBool:		#if we want to pause show a tint
			tint.show()
		else:				# if we want to resume hide the tint
			tint.hide()
		get_tree().call_group(0, "GUI buttons", "set_disabled", someBool)		#enable/disable the menu buttons
		
func is_game_paused():
	if (get_tree().is_paused()):
		return true
	else:
		return false
		
func game_over():
	print("game over")
	is_level_complete = true
	var kalulu = kalulu_scene.instance()
	var ctrlGUI = get_tree().get_root().get_child(1).get_child(2).get_node("Control")
	ctrlGUI.add_child(kalulu)
	kalulu.end()
	game_manager.pause_game(true)
	
func get_kalulu_scene():
	return kalulu_scene