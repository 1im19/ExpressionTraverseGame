extends KinematicBody2D

onready var player = get_node("../../MC_KinematicBody2D")
var speed = Vector2.ZERO

func _physics_process(delta):
	var collision = move_and_collide(speed * delta)
	if collision && player.attacking:
		queue_free()


