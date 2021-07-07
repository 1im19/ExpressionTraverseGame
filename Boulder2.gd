extends KinematicBody2D

var speed = Vector2.ZERO
var maxspeed = 400
var startpos = Vector2(-30.368, 849.413)

func _physics_process(delta):
	var vector = Vector2.ZERO
	vector.x = maxspeed * -1
	speed = vector
	var collision = move_and_collide(speed *  delta)
	if collision:
		if collision.collider.name == "Portal2":
			position = startpos
