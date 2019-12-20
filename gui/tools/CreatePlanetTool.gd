extends Node
signal planet_created

enum PLANET_CREATION_MODE{clickAndDrag, threeSteps}

onready var Planet = preload("res://objects/planet/Planet.tscn")

var mode = PLANET_CREATION_MODE.clickAndDrag
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
	return get_viewport().canvas_transform.affine_inverse().xform(pos)

func _on_color_changed(color):
	newPlanetColor = color
func _on_mass_entered(mass):
	newMass = mass
func _on_radius_entered(radius):
	newRadius = radius
func _on_new_planet_requested(pos, vel, radius = newRadius, mass = newMass, color = newPlanetColor):
	create_planet(pos,vel,radius, mass, color)
func _on_ClickAndDrag_pressed():
	mode = PLANET_CREATION_MODE.clickAndDrag
	$ThreeStepsPlanetCreator.initialize()
func _on_ThreeSteps_pressed():
	mode = PLANET_CREATION_MODE.threeSteps
	$ClickAndDragPlanetCreator.initialize()