extends LineEdit
onready var createPlanetTool = get_node("/root/Main/CreatePlanetTool")

signal mass_entered

func _ready():
	connect("mass_entered", createPlanetTool, "_on_mass_entered")

func _on_MassLineEdit_text_changed(new_text):
	if new_text.is_valid_float():
		var mass = float(new_text)
		if mass > 0.0 and mass < 100000.0:
			emit_signal("mass_entered", mass)
		