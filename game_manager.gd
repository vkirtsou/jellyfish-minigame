extends Node

var jellies_to_catch = 4
var i = 0

func _ready():
	
	pass
	
func click_tries():
	print("clicked!")
	i = i + 1
	if (i == jellies_to_catch):
		print("done!")
		get_tree().set_pause(true)
		#TODO: END GAME!
		
func pause_game(someBool):
	get_tree().set_pause(someBool)				# pause the game
	var tint = get_tree().get_root().get_child(1).get_node("tint")
	if someBool:		#if we want to pause show a tint
		tint.show()
	else:				# if we want to resume hide the tint
		tint.hide()
	get_tree().call_group(0, "GUI buttons", "set_disabled", someBool)		#enable/disable the menu buttons