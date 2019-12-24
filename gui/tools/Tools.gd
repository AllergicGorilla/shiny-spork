extends Control

var peek_physics = true
var current_planet setget set_current_planet
var follow_planet = false
const Tool = preload("res://gui/tools/Tool.gd")
var current_tool: Tool

signal current_planet_changed


func _ready():
	current_tool = $CreatePlanet


func _unhandled_input(event):
	if is_instance_valid(current_tool):
		current_tool.handle_input(event)


func set_current_planet(new):
	new.connect("tree_exited", self, "_on_current_planet_tree_exited")
	current_planet = new
	if follow_planet:
		follow_current_planet()
	emit_signal("current_planet_changed", current_planet)


func follow_current_planet():
	if is_instance_valid(current_planet):
		current_planet.get_node("Camera").current = true


func _on_current_planet_tree_exited():
	current_planet = null
	emit_signal("current_planet_changed")


func _on_followPlanet_pressed():
	follow_planet = !follow_planet


func _on_createPlanet_pressed():
	current_tool = $CreatePlanet

func _on_peekPhysics_pressed():
	Globals.VIEWPHYSICS = !Globals.VIEWPHYSICS
	var planets = get_tree().get_nodes_in_group("planets")
	for p in planets:
		if Globals.VIEWPHYSICS:
			p.show_physics()
		else:
			p.hide_physics()

