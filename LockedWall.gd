extends StaticBody2D	

onready var player = get_node("../MC_KinematicBody2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.levelclear:
		queue_free()
