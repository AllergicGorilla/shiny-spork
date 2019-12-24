extends "res://gui/tools/Tool.gd"

signal planet_created

onready var Planet = preload("res://objects/planet/Planet.tscn")

var planet_position := Vector2(0,0)
var planet_velocity := Vector2(0,0)
var planet_color := Color.red
var planet_radius := 10.0
var planet_mass := 1.0

func create_planet(p_mass = planet_mass,p_color = planet_color,p_position = planet_position,p_velocity = planet_velocity,p_radius = planet_radius):
	var planet = Planet.instance()
	planet.mass = p_mass
	planet.color = p_color
	planet.position = p_position
	planet.linear_velocity = p_velocity
	planet.radius = p_radius
	emit_signal("planet_created", planet)
