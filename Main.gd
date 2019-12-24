extends Node

onready var universe = $Universe
onready var tools = $GUILayer/GUI/Tools


#SIGNAL HANDLING
func _on_planet_created(new_planet):
	new_planet.add_to_group("planets")
	universe.add_child(new_planet)
	new_planet.connect("planet_selected", self, "_on_planet_selected")

func _on_planet_selected(planet):
	tools.current_planet = planet
