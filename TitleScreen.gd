extends CanvasLayer

func _on_Play_pressed():
	get_tree().change_scene("res://Play.tscn")


func _on_Editor_pressed():
	get_tree().change_scene("res://Main.tscn")
