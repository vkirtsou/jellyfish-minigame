extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var kalulu_anim
var kalulu_player
var sound_playing

func _ready():
	kalulu_anim = get_node("CanvasLayer/kalulu")
	kalulu_player = get_node("CanvasLayer/kaluluPlayer")
	kalulu_player.connect("audio_finished", self, "_on_sound_finished")
	sound_playing = false
	
func intro():			# kalulu intro
	kalulu_anim.set_animation("show")
	yield(kalulu_anim, "finished")
	kalulu_player.play_sound("kalulu_intro_jellyfish_language")
	talk_animations()
		
func help():			# kalulu help --> kalulu button
	kalulu_anim.set_animation("show")
	yield(kalulu_anim, "finished")
	kalulu_player.play_sound("kalulu_help_jellyfish_language")
	talk_animations()

func end():				#kalulu end
	get_parent().hide_kalulu_button()
	kalulu_anim.set_animation("show")
	yield(kalulu_anim, "finished")
	kalulu_player.play_sound("kalulu_end_jellyfish_language")
	talk_animations()
	
func talk_animations():
	while (true):			#repeat the animation cycle
		kalulu_anim.set_animation("talk1")
		yield(kalulu_anim, "finished")
		kalulu_anim.set_animation("talk2")
		yield(kalulu_anim, "finished")

func _on_sound_finished(key):
	kalulu_anim.set_animation("hide")
	yield(kalulu_anim, "finished")
	queue_free()
	if (!key == "kalulu_end_jellyfish_language"):
		game_manager.pause_game(false)	
	else:
		pass
		# instantiate the button on the right