extends Node

onready var universe = $Universe

func _input(event):
	if event.is_action_pressed("go_to_title_screen"):
		get_tree().change_scene("res://TitleScreen.tscn")
