extends Node
signal planet_created

onready var Planet = preload("res://objects/planet/Planet.tscn")

var newPlanetColor = Color(255,0,0)
var newMass = 1.0
var newRadius = 10.0

func create_planet(pos, vel, radius, mass, color):
	var planet = Planet.instance()
	var body = planet.get_node("Body")
	body.mass = mass
	body.color = color
	body.position = pos
	body.linear_velocity = vel
	body.radius = radius
	emit_signal("planet_created", planet)

func gui_to_world_pos(pos):
	return pos - get_viewport().canvas_transform.get_origin()

func _on_color_entered(color):
	newPlanetColor = color
func _on_MassLineEdit_mass_entered(mass):
	newMass = mass


func _on_new_planet_requested(guiPos, vel, radius = newRadius, mass = newMass, color = newPlanetColor):
	create_planet(gui_to_world_pos(guiPos),vel,radius, mass, color)
