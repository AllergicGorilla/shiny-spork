extends Node
enum TOOL{createPlanet, freeCursor, applyForce, peekPhysics, followPlanet}
enum PLANET_CREATION_MODE{clickAndDrag, threeSteps}

var current = TOOL.freeCursor
var mode = PLANET_CREATION_MODE.clickAndDrag
var currentPlanetBody: RigidBody2D setget currentPlanetBody_set

signal currentPlanetBody_changed

func currentPlanetBody_set(new: RigidBody2D):
	new.connect("tree_exited", self, "_on_currentPlanetBody_tree_exited")
	currentPlanetBody = new
	emit_signal("currentPlanetBody_changed")
func _on_currentPlanetBody_tree_exited():
	currentPlanetBody = null
	emit_signal("currentPlanetBody_changed")
func world_pos(event):
	return event.position
func gui_to_world_pos(pos):
	return pos - get_viewport().canvas_transform.get_origin()

func _on_createPlanet_pressed():
	current = TOOL.createPlanet
func _on_freeCursor_pressed():
	current = TOOL.freeCursor
func _on_applyForce_pressed():
	current = TOOL.applyForce
func _on_followPlanet_pressed():
	current = TOOL.followPlanet
