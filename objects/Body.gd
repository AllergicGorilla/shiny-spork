extends RigidBody2D

export var gravityForce = Vector2(0,0)
export var radius = 10
export var color = Color(255,0,0)

onready var VelocityVector = get_node("../VelocityVector")
onready var ForceVector = get_node("../ForceVector")


func _ready():
	VelocityVector.tip = linear_velocity
	$collisionShape.shape.radius = radius
func _integrate_forces(state):
	set_applied_force(gravityForce)
func _process(delta):
	VelocityVector.tip = linear_velocity
	VelocityVector.position = position
	ForceVector.tip = gravityForce
	ForceVector.position = position
	#update()
func _draw():
	draw_circle(Vector2(0,0), radius, color)
