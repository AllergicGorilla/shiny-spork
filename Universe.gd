extends Node2D

var VIEWPHYSICS: bool = true
onready var createPlanetTool = get_node("/root/Main/CreatePlanetTool")

func _ready():
	createPlanetTool.connect("planet_created", self, "_on_planet_created")

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
#func _on_Area2D_body_exited(body):
	#body.get_parent().queue_free()

func _on_planet_created(newPlanet):
	newPlanet.add_to_group("planets")
	add_child(newPlanet)
