extends Control
const PlanetCreator = preload("res://gui/tools/planet creation/PlanetCreator.gd")
onready var planet_creator = $ClickAndDragCreator


func handle_input(event):
	planet_creator.handle_input(event)


func _on_MassEditor_mass_entered(mass):
	planet_creator.planet_mass = mass


func _on_RadiusEditor_radius_entered(radius):
	planet_creator.planet_radius = radius


func _on_ColorPicker_color_changed(color):
	planet_creator.planet_color = color


func _on_ClickAndDrag_pressed():
	planet_creator.reset()
	planet_creator = $ClickAndDragCreator


func _on_ThreeSteps_pressed():
	planet_creator.reset()
	planet_creator = $ThreeStepsCreator
