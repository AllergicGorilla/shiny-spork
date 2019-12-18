extends RigidBody2D

export var gravityForce = Vector2(0,0)
export var radius = 10

onready var VelocityVector = get_node("../VelocityVector")
onready var ForceVector = get_node("../ForceVector")
onready var tools = get_node("/root/Tools")

signal body_selected

func _ready():
	VelocityVector.vec = linear_velocity
func _integrate_forces(state):
	set_applied_force(gravityForce)
func _process(delta):
	VelocityVector.vec = linear_velocity
	VelocityVector.position = position
	ForceVector.vec = gravityForce
	ForceVector.position = position
	#update()
func _draw():
	draw_circle(Vector2(0,0), radius, Color(255,0,0))


func _on_Body_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick"):
		emit_signal("body_selected")
		tools.currentPlanetBody = self
		print("body selected")
