extends Node
enum TOOL{createPlanet, freeCursor, applyForce, peekPhysics, followPlanet}

var current = TOOL.freeCursor
var currentPlanetBody: RigidBody2D setget currentPlanetBody_set
onready var CreatePlanetTool = preload("res://gui/tools/CreatePlanetTool.tscn")


signal currentPlanetBody_changed


func currentPlanetBody_set(new: RigidBody2D):
	new.connect("tree_exited", self, "_on_currentPlanetBody_tree_exited")
	currentPlanetBody = new
	emit_signal("currentPlanetBody_changed")
func _on_currentPlanetBody_tree_exited():
	currentPlanetBody = null
	emit_signal("currentPlanetBody_changed")


