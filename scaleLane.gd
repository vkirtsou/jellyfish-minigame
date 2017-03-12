extends Container

var screen_size

func _ready():
	screen_size = get_viewport_rect().size;
	set_size(Vector2(screen_size.x/9, screen_size.y))		# a vertical slice of the 1/9th of the screen 
	print(get_size())
	get_node("bg1").set_scale(Vector2(get_size().x/100, get_size().y/100 + 3))
	print (get_node("bg1").get_scale())