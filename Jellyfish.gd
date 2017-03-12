extends Control

var jelly_anim		#the jellyfish
var bubble_player	#the audio for bubble sound
var phonetic_player #the audio for phonetic sound
var jelly_button	#the button that makes the jellyfish clickable
var fx_anim			#the animatorPlayer for the correct/wrong fx

var blue_jelly_animations	# dictionary with the animations for the blue jelly
var red_jelly_animations	# dictionary with the animations for the red jelly
var jelly_color_anim		# dictionary of the jelly animations for the color that was randomly selected
var is_correct_jelly		# bool to differentiate between correct/wrong jellyfish

func _ready():
	jelly_button = get_node("Position2D/jelly_anim/jelly_button")
	jelly_anim = get_node("Position2D/jelly_anim")
	bubble_player = get_node("bubblePlayer")
	bubble_player.connect("audio_finished", self, "_on_sound_finished")
	phonetic_player = get_node("PhoneticPlayer")
	fx_anim = get_node("animator_fx")
	blue_jelly_animations = { "default": "b_default", "selected": "b_selected", "happy": "b_happy" }
	red_jelly_animations = { "default": "r_default", "selected": "r_selected", "happy": "r_happy" }
	randomize()
	choose_jelly_properties()		# choose the color of the jelly, as well as if it has a phonetic or no
	set_process(true)
	
func _process(delta):
	if !get_node("animator").is_playing():		# delete the jelly when out of the screen
		free()
		
func choose_jelly_properties():
	# choosing the color of jelly and resizing elements if needed
	var choice = int(rand_range(0,2))
	if choice == 0:
		var new_pos = Vector2(-75.0, -80.0)
		var fx_new_scale = Vector2(0.3, 0.3)
		var btn_new_size = Vector2(150, 180)
		jelly_color_anim = red_jelly_animations
		# apply the changes in the graphics and effects for the smaller red jelly
		get_node("Position2D/jelly_anim/fx_success").set_pos(new_pos)		# reposition and rescale the fx to fit the (smaller) red jelly
		get_node("Position2D/jelly_anim/fx_success").set_scale(fx_new_scale)
		get_node("Position2D/jelly_anim/fx_fail").set_pos(new_pos)		# reposition and rescale the fx to fit the (smaller) red jelly
		get_node("Position2D/jelly_anim/fx_fail").set_scale(fx_new_scale)
		get_node("Position2D/jelly_anim/fx_fail2").set_pos(new_pos)		# reposition and rescale the fx to fit the (smaller) red jelly
		get_node("Position2D/jelly_anim/fx_fail2").set_scale(fx_new_scale)
		get_node("Position2D/jelly_anim/ParticlesLeft").set_pos(Vector2(0, 13))		# reposition and rescale the fx to fit the (smaller) red jelly
		get_node("Position2D/jelly_anim/ParticlesLeft").set_scale(fx_new_scale)
		get_node("Position2D/jelly_anim/ParticlesRight").set_pos(Vector2(0, 13))
		get_node("Position2D/jelly_anim/ParticlesRight").set_scale(fx_new_scale)
		get_node("Position2D/jelly_anim/ParticlesFail").set_scale(Vector2(0.2, 0.2))
		get_node("Position2D/jelly_anim/phonetic_label").set_pos(Vector2(-50, -75))
		jelly_button.set_pos(Vector2(50, 30))
		jelly_button.set_size(btn_new_size)
	else:
		jelly_color_anim = blue_jelly_animations
	
	jelly_anim.set_animation(jelly_color_anim["default"])	# show the default animation of jelly (either color)
	
	# decide if the jelly will have a letter or not
	var choice = int(rand_range(0,3))
	if choice == 0:					# jelly has a letter
		is_correct_jelly = true
		get_node("Position2D/jelly_anim/phonetic_label").set_text("o")
		var choice = int(rand_range(0,2))
		if choice == 0:				# sometimes show the letter in uppercase
			get_node("Position2D/jelly_anim/phonetic_label").set_uppercase(true)
	else:							# jelly doesn't have a letter
		is_correct_jelly = false

func _on_jelly_button_pressed():
	game_manager.click_tries()
	game_manager.pause_game(true)		# pause the game but not the jelly animations
	play_sound_bubble()					# play the bubble/select sound
	if is_correct_jelly:				# if jelly has a letter (is correct)
		play_sound_phonetic()
		play_sound_correct()
		play_animation_correct()	
	else:								# if jelly doesn't have a letter (is wrong)
		play_sound_wrong()
		play_animation_wrong()
	jelly_button.set_disabled(true)		# disable the button of the jellyfish in any case
	# TODO: mark a jelly life "done" -> Missing graphic assets!
	
func play_animation_correct():
	jelly_anim.set_animation(jelly_color_anim["selected"])
	yield(jelly_anim, "finished")
	show_success_fx()
	jelly_anim.set_animation(jelly_color_anim["happy"])
	yield(jelly_anim, "finished")
	jelly_anim.set_animation(jelly_color_anim["default"])
	yield(jelly_anim, "finished")
	if (!game_manager.clicks >= game_manager.jellies_to_catch):		# if there are still jellies to catch
		game_manager.pause_game(false)		# unpause
		jelly_anim.set_opacity(0.3)			# make the jelly look "disabled"/unselectable
	else:									# level complete: special effects + sounds (missing sound assets! temp substituted with a bubble sound)
		play_sound_level_completed()
		
func play_animation_wrong():
	jelly_anim.set_animation(jelly_color_anim["selected"])
	yield(jelly_anim, "finished" )
	show_fail_fx()
	jelly_anim.set_animation(jelly_color_anim["default"])
	yield(jelly_anim, "finished" )
	if (!game_manager.clicks >= game_manager.jellies_to_catch):		# if there are still jellies to catch
		game_manager.pause_game(false)		# unpause
		jelly_anim.set_opacity(0.3)			# make the jelly look "disabled"/unselectable
	else:
		play_sound_level_completed()		

func play_sound_phonetic():
	phonetic_player.play("phoneme_o", true);
	
func play_sound_bubble():
	bubble_player.play("jellyfish_bubble_random_01", true)

func play_sound_correct():		# waiting for audio files
	pass
func play_sound_wrong():		# waiting for audio files
	pass	
	
func play_sound_level_completed():
	bubble_player.play_sound("jellyfish_bubble_random_05")
	
func show_success_fx():
	fx_anim.play("success_fx")				# had to change animator_fx to pause mode -> process in order to play!
	
func show_fail_fx():
	fx_anim.play("fail_fx")
	yield(fx_anim, "finished")
	play_sound_phonetic()

func _on_sound_finished(key):
	print("finished playing")
	game_manager.game_over()
	