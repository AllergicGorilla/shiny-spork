extends ColorPickerButton

func _ready():
	emit_signal("color_changed", color)
