extends Position2D

#export (PackedScene) var spawnScene
#export (PackedScene) var spawnScene2
#onready var spawnReference = load(spawnScene.get_path())		# reference to the scene to be loaded
#onready var spawnReference2 = load(spawnScene2.get_path())		# reference to the scene to be loaded

#onready var spawnRefs = { 1: load(spawnScene1.get_path()), 2:load(spawnScene2.get_path()) }

#export (NodePath) var timerPath
#onready var timerNode = load(timerPath)
var spawnReference
var timerNode
var spawnInstance

export (float) var minWaitTime
export (float) var maxWaitTime

func _ready():
	spawnReference = load("res://jelly.tscn")
	timerNode = get_node("timer")
	timerNode.connect("timeout", self, "_on_timer_timeout")
	randomize()
	timerNode.set_wait_time(rand_range(minWaitTime, maxWaitTime))
	timerNode.start()
	var to_spawn = int(rand_range(0, 4)) 
	if (to_spawn == 0):
		spawnInstance  = spawnReference.instance()

func _on_timer_timeout():
	spawnInstance  = spawnReference.instance()
	print("spawned")
	get_parent().add_child(spawnInstance) # not child of the spawner because it will move with the spawner
	#add_child(spawnInstance) 
	#spawnInstance.set_global_pos(get_global_pos())
	
	timerNode.set_wait_time(rand_range(minWaitTime, maxWaitTime))
	timerNode.start()
