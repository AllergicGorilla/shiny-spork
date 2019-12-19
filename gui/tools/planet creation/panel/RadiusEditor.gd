extends LineEdit

signal radius_entered

func _on_RadiusEditor_text_entered(new_text):
	if new_text.is_valid_float():
		var radius = float(new_text)
		if radius > 0.0 and radius < 100000.0:
			emit_signal("radius_entered", radius)
