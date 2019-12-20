extends Node
enum TOOL{createPlanet, freeCursor, applyForce, peekPhysics}


var currentState = TOOL.freeCursor setget set_current_state

var currentPlanet setget set_currentPlanet
var followPlanet = false

signal currentPlanet_changed

func gui_to_world_pos(pos):
	return pos - get_viewport().canvas_transform.get_origin()

func set_current_state(newState):
	currentState = newState

func set_currentPlanet(new):
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
	currentState = TOOL.createPlanet
func _on_freeCursor_pressed():
	currentState = TOOL.freeCursor
func _on_applyForce_pressed():
	currentState = TOOL.applyForce
func _on_followPlanet_pressed():
	followPlanet = !followPlanet
func _on_peekPhysics_pressed():
	Globals.VIEWPHYSICS = !Globals.VIEWPHYSICS
	Helpers.debug_print(Globals.VIEWPHYSICS)
	if Globals.VIEWPHYSICS:
		get_tree().call_group("planets", "show_physics")
	else:
		get_tree().call_group("planets", "hide_physics")
