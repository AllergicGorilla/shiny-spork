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
