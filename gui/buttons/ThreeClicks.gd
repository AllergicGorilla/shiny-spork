extends Button

onready var tools = get_node("/root/Tools")

func _on_ThreeClicks_pressed():
	tools.mode = tools.PLANET_CREATION_MODE.threeSteps
