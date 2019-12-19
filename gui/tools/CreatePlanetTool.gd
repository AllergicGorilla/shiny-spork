extends Node
signal planet_created

onready var Planet = preload("res://universe/planet/Planet.tscn")

var newPlanetColor = Color(255,0,0)
var newMass = 1.0
var newRadius = 10.0

func create_planet(pos, vel, newRadius = 10.0, mass= newMass, color = newPlanetColor):
	var planet = Planet.instance()
	var body = planet.get_node("Body")
	body.mass = mass
	body.color = color
	body.position = pos
	body.linear_velocity = vel
	body.radius = newRadius
	emit_signal("planet_created", planet)

func _on_mass_entered(mass):
	newMass = mass
func _on_color_entered(color):
	newPlanetColor = color