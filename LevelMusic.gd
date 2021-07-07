extends Node

var level_music = load("Music/Level.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music():
	
	$AudioStreamPlayer.stream = level_music
	$AudioStreamPlayer.play()
