extends KinematicBody2D

onready var player = get_node("../MC_KinematicBody2D")
onready var timer = get_node("Timer")
onready var animation = $ZombieBoss

var speed = Vector2.ZERO
var maxspeed = 400
var health = 3
var direction = 0

func _physics_process(delta):
	if(timer.is_stopped()):
		timer.start()
		if direction < 4:
			direction += 1
		else:
			direction = 1
	
	var vector = Vector2.ZERO
	if direction == 1:
		vector.x = maxspeed * -1
		vector.y = 0
		animation.flip_h = true
	elif direction == 2:
		vector.x = 0
		vector.y = maxspeed * 1
		animation.flip_h = true
	elif direction == 3:
		vector.x = maxspeed * 1
		vector.y = 0
		animation.flip_h = false
	elif direction == 4:
		vector.x = 0
		vector.y = maxspeed * -1
		animation.flip_h = false
	speed = vector
	
	var collision = move_and_collide(speed * delta)
	if collision:
		if collision.collider.name == "MC_KinematicBody2D" && player.attacking:
			health -= 1
			if health <= 0:
				player.defeatedboss = true
				queue_free()
