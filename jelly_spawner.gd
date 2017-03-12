extends Position2D

var spawnReference
var timerNode
var spawnInstance

export (float) var minWaitTime
export (float) var maxWaitTime

func _ready():
	spawnReference = preload("res://jelly.tscn")
	timerNode = get_node("timer")
	timerNode.connect("timeout", self, "_on_timer_timeout")
	randomize()
	timerNode.set_wait_time(rand_range(0, 3))		# first spawn should take less time to happen, custom seconds 0 to 3
	timerNode.start()

func _on_timer_timeout():
	var dont_spawn = int(rand_range(0, 3))		# give a chance to the spawner to not spawn anything, to make it more realistic
	if (!dont_spawn == 0):						# 2/3 chance to spawn
		spawnInstance  = spawnReference.instance()
		get_parent().add_child(spawnInstance) # not child of the spawner because it will move with the spawner
	timerNode.set_wait_time(rand_range(minWaitTime, maxWaitTime))	# reset timer
	timerNode.start()
