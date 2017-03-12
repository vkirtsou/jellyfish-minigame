extends SamplePlayer

var started_playing
var player
var last_sound

func _ready():
	player = get_node(".")
	started_playing = false
	player.add_user_signal("audio_finished", [{"sound": TYPE_STRING}])
	set_process(true)
	
func _process(delta):
	if (!player.is_active() && started_playing):
		player.emit_signal("audio_finished", last_sound)
		started_playing = false
		
func play_sound(key):
	player.play(key)
	started_playing = true
	last_sound = key
