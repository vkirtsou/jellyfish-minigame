extends VBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screen_size
var container_size
var button

func _ready():
	#fit_child_in_rect(VBoxContainer, Rect2(50, 50, 200, 200))
	screen_size = get_viewport_rect().size;
	print("cont. size: ", self.get_size());
	var cont_x = screen_size.x/9
	var cont_y = screen_size.y
	print(cont_x, cont_y)
	set_size(Vector2(cont_x, cont_y))
	print("screen resolution: ", screen_size);
	print("container size: ", self.get_size());
	
