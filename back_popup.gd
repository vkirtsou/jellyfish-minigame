extends Sprite

func _ready():
	var viewport_size = get_viewport_rect().size
	set_pos(Vector2(viewport_size.width/2, viewport_size.height/2)) # center it
	get_node("ButtonCancel").connect("pressed", self, "_on_ButtonCancel_pressed")
	get_node("ButtonConfirm").connect("pressed", self, "_on_ButtonConfirm_pressed")
	
func _on_ButtonCancel_pressed():
	get_parent().queue_free()
	game_manager.pause_game(false)
	
func _on_ButtonConfirm_pressed():
	get_parent().queue_free()
	game_manager.pause_game(false)