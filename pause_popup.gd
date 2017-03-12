extends Sprite

func _ready():
	var viewport_size = get_viewport_rect().size
	set_pos(Vector2(viewport_size.width/2, viewport_size.height/2)) # center it
	get_node("ButtonResume").connect("pressed", self, "_on_ButtonResume_pressed")

func _on_ButtonResume_pressed():
	game_manager.pause_game(false)
	get_parent().queue_free()
	
