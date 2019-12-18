extends Node
enum TOOL{createPlanet, freeCursor, applyForce, peekPhysics, followPlanet}
var currentTool = TOOL.freeCursor
var currentPlanetBody: RigidBody2D setget set_currentPlanetBody, get_currentPlanetBody

signal currentPlanetBody_changed

func set_currentPlanetBody(new: RigidBody2D):
	new.connect("tree_exited", self, "_on_currentPlanetBody_tree_exited")
	currentPlanetBody = new
	emit_signal("currentPlanetBody_changed")
func _on_currentPlanetBody_tree_exited():
	currentPlanetBody = null
	emit_signal("currentPlanetBody_changed")
func get_currentPlanetBody():
	return currentPlanetBody

