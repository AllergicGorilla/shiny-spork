extends Node2D

export (PackedScene) var Planet

#enum TOOL{createPlanet, freeCursor, applyForce}
var VIEWPHYSICS: bool = true

var prevMousePos = Vector2()
#export var currentTool = TOOL.freeCursor
onready var tools = get_node("/root/Tools")

func _unhandled_input(event):
	#This is game logic to make an arrow appear (representing the starting velocity)
	#whenever the player clicks, holds and drags their mouse
	#during the creation of a new Planet
	if tools.currentTool == tools.TOOL.createPlanet:
		if event.is_action_pressed("leftMouseClick"):
			$velocityLine.show()
			print("Mouse Click at: ", get_global_mouse_position())
			prevMousePos = get_global_mouse_position()
			$velocityLine.origin = prevMousePos
		elif event.is_action_released("leftMouseClick"): 
			$velocityLine.hide()
			var planet = Planet.instance()
			var body = planet.get_node("Body")
			body.position = prevMousePos
			body.linear_velocity = (get_global_mouse_position() - prevMousePos)
			planet.add_to_group("planets")
			add_child(planet)
		elif event is InputEventMouseMotion:
			$velocityLine.vec = get_global_mouse_position()
func _physics_process(delta):
	#N-body gravitation
	var planets = get_tree().get_nodes_in_group("planets")
	for p1 in planets:
		var body1 = p1.get_node("Body")
		var gravForce = Vector2(0,0)
		for p2 in planets:
			if p1 != p2:
				var body2 = p2.get_node("Body")
				var distanceVec = body1.get_position() - body2.get_position()
				gravForce += Newton.gravitational_force(body1.mass, body2.mass, distanceVec)
		body1.gravityForce = gravForce



#Toggle whether the velocity and forces are visible
func _on_peekPhysics_pressed():
	VIEWPHYSICS = !VIEWPHYSICS
	var planets = get_tree().get_nodes_in_group("planets")
	for p1 in planets:
		var vel = p1.get_node("VelocityVector")
		var force = p1.get_node("ForceVector")
		vel.visible = VIEWPHYSICS
		force.visible = VIEWPHYSICS
func _on_Area2D_body_exited(body):
	body.get_parent().queue_free()

func _on_createPlanet_pressed():
	tools.currentTool = tools.TOOL.createPlanet
func _on_freeCursor_pressed():
	tools.currentTool = tools.TOOL.freeCursor
func _on_applyForce_pressed():
	tools.currentTool = tools.TOOL.applyForce
func _on_followPlanet_pressed():
	tools.currentTool = tools.TOOL.followPlanet
