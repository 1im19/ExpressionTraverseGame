extends Control


func _on_Level1Button_pressed():
	get_tree().change_scene("res://Level1.tscn")


func _on_Level2Button_pressed():
	get_tree().change_scene("res://Level2.tscn")


func _on_Level3Button_pressed():
	get_tree().change_scene("res://Level3.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
