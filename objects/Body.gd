extends RigidBody2D

onready var planet = get_parent()
onready var VelocityVector = get_node("../Following/VelocityVector")
onready var ForceVector = get_node("../Following/ForceVector")


func _ready():
	VelocityVector.tip = linear_velocity
	$collisionShape.shape.radius = planet.radius
	mass = planet.mass
func _integrate_forces(state):
	set_applied_force(planet.gravityForce)
func _process(delta):
	VelocityVector.tip = linear_velocity
	ForceVector.tip = planet.gravityForce
	#update()
func _draw():
	draw_circle(Vector2(0,0), planet.radius, planet.color)
