extends ColorPickerButton
onready var createPlanetTool = get_node("/root/Main/CreatePlanetTool")

func _ready():
	connect("color_changed", createPlanetTool, "_on_color_entered")
	emit_signal("color_changed", color)
