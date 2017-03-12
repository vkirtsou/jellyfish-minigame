extends Node

var jellies_to_catch = 4
var tries = 0
var kalulu_scene

func _ready():
	kalulu_scene = preload("res://Kalulu_ctrl.tscn")			#had to preload because it takes a lot of time to load due to image errors
	pass
func click_tries():
	tries = tries + 1
		
func pause_game(someBool):
	get_tree().set_pause(someBool)				# pause the game
	if (get_tree().get_current_scene().get_name() == "mainCtrl"):
		var tint = get_tree().get_current_scene().get_node("tint")
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
	var kalulu = kalulu_scene.instance()		#instantiate kalulu scene
	#var ctrlGUI = get_tree().get_root().get_child(1).get_child(2).get_node("Control")
	var ctrlGUI = get_tree().get_current_scene().get_node("HBoxContainer/Control")
	ctrlGUI.add_child(kalulu)
	kalulu.end()								# play the ending animation from kalulu
	
func get_kalulu_scene():
	return kalulu_scene