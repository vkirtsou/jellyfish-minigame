extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("spawnbutton").connect("pressed", self, "spawn_jelly")

func spawn_jelly():
	print("spawned")
	var jelly = load("res://jelly.tscn")
	var node = jelly.instance()
	add_child(node)
	