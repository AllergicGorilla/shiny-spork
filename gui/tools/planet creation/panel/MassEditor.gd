extends LineEdit

signal mass_entered

func _on_MassEditor_text_entered(new_text):
	if new_text.is_valid_float():
		var mass = float(new_text)
		if mass > 0.0 and mass < 100000.0:
			emit_signal("mass_entered", mass)
