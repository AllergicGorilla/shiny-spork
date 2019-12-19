extends Node
enum TOOL{createPlanet, freeCursor, applyForce, peekPhysics}
enum PLANET_CREATION_MODE{clickAndDrag, threeSteps}

var current = TOOL.freeCursor
var mode = PLANET_CREATION_MODE.clickAndDrag
var currentPlanet setget currentPlanet_set
var followPlanet = false

signal currentPlanet_changed

func gui_to_world_pos(pos):
	return pos - get_viewport().canvas_transform.get_origin()

func currentPlanet_set(new):
	new.connect("tree_exited", self, "_on_currentPlanetBody_tree_exited")
	currentPlanet = new
	if followPlanet:
		follow_current_planet()
	emit_signal("currentPlanet_changed", currentPlanet)
func follow_current_planet():
	if is_instance_valid(currentPlanet):
		currentPlanet.get_node("Body/Camera").current = true	

func _on_currentPlanetBody_tree_exited():
	currentPlanet = null
	emit_signal("currentPlanet_changed")

func _on_createPlanet_pressed():
	current = TOOL.createPlanet
func _on_freeCursor_pressed():
	current = TOOL.freeCursor
func _on_applyForce_pressed():
	current = TOOL.applyForce
func _on_followPlanet_pressed():
	followPlanet = !followPlanet

