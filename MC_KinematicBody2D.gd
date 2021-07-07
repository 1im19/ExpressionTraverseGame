extends KinematicBody2D

var speed = Vector2.ZERO
const maxspeed = 400
const maxhealth = 100
var health = maxhealth
var attacking = false
var collectedexpression = false
var levelclear = false
var defeatedboss = false
var blinking = false

var expressionname = ["Happy", "Sad", "Angry"]
var enemyname1 = ["Mushroom1", "Mushroom2", "Mushroom3", "Mushroom4", "Mushroom5", "Mushroom6", "Mushroom7", "Mushroom8", "Mushroom9", "Mushroom10", "Mushroom11"]
var enemyname2 = ["Bat1", "Bat2", "Bat3", "Bat4", "Bat5", "Bat6", "Bat7", "Bat8", "Bat9", "Bat10"]
var enemyname3 = ["Zombie1", "Zombie2", "Zombie3", "Zombie4", "Zombie5", "Zombie6", "Zombie7", "Zombie8", "Zombie9", "Zombie10"]
var obstaclename = ["Boulder1", "Boulder2"]
var bossname = ["MushroomBoss", "BatBoss", "ZombieBoss"]


onready var animationplayer = $AnimationPlayer

onready var idle = $MC_Idle
onready var walkdown = $MC_WalkDown
onready var walkup = $MC_WalkUp
onready var walkright = $MC_WalkRight
onready var walkleft = $MC_WalkLeft
onready var attackdown = $MC_AttackDown

onready var timer = get_node("Timer")
onready var timer2 = get_node("Timer2")
onready var HPtext = get_node("HP Text")
onready var sprite = get_node("MC Sprite")

func smalldamage():
	if timer.is_stopped():
		timer.start()
		health -= 5
		
func bigdamage():
	if timer.is_stopped():
		timer.start()
		health -= 10
		
func idle():
	animationplayer.play("Idle")
	idle.visible = true
	walkdown.visible = false
	walkup.visible = false
	walkright.visible = false
	walkleft.visible = false
	
func walkdown():
	animationplayer.play("WalkDown")
	walkdown.visible = true
	idle.visible = false
	walkup.visible = false
	walkright.visible = false
	walkleft.visible = false
	
func walkup():
	animationplayer.play("WalkUp")
	walkup.visible = true
	idle.visible = false
	walkdown.visible = false
	walkright.visible = false
	walkleft.visible = false
	
func walkright():
	animationplayer.play("WalkRight")
	walkright.visible = true
	idle.visible = false
	walkdown.visible = false
	walkup.visible = false
	walkleft.visible = false
	
func walkleft():
	animationplayer.play("WalkLeft")
	walkleft.visible = true
	idle.visible = false
	walkdown.visible = false
	walkup.visible = false
	walkright.visible = false
	

func _physics_process(delta):
		
	#8 directions
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		if Input.is_action_just_pressed("ui_accept"):
			speed = input_vector * 20
			attacking = true
		else:
			speed = input_vector
			attacking = false
		if Input.is_action_pressed("ui_down"):
			walkdown()
		elif Input.is_action_pressed("ui_up"):
			walkup()
		elif Input.is_action_pressed("ui_right"):
			walkright()
		elif Input.is_action_pressed("ui_left"):
			walkleft()
	else:
		speed = Vector2.ZERO
		idle()

	
	var collision = move_and_collide(speed * delta * maxspeed)
	if collision:
		print("I collided with ", collision.collider.name)
		for i in enemyname1.size():
			if collision.collider.name == enemyname1[i]:
				smalldamage()
		for i in enemyname2.size():
			if collision.collider.name == enemyname2[i]:
				smalldamage()
		for i in enemyname3.size():
			if collision.collider.name == enemyname3[i]:
				smalldamage()
		for i in obstaclename.size():
			if collision.collider.name == obstaclename[i]:
				bigdamage()
		for i in bossname.size():
			if collision.collider.name == bossname[i]:
				bigdamage()
		for i in expressionname.size():
			if collision.collider.name == expressionname[i]:
				collectedexpression = true
	
	if health <= 0:
		health = 0
		get_tree().change_scene("res://GameOver.tscn")
		
	if collectedexpression && defeatedboss:
		levelclear = true
	
	HPtext.text = "HP: " + str(health)
	
