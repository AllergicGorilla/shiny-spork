extends RigidBody2D

signal planet_selected

export var radius: float = 1.0
export var color: Color = Color.white
onready var planet = get_parent()
var gravity_force = Vector2(0,0)
var visible_text = "Speed: %.2f\nForce: %.2f\nMass: %.2f"

func _ready():
	$collisionShape.shape.radius = radius
	if Globals.VIEWPHYSICS:
		show_physics()
	else:
		hide_physics()
func _integrate_forces(state):
	set_applied_force(gravity_force)
func _draw():
	draw_circle(Vector2(0,0), radius, color)
func _on_Planet_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick"):
		emit_signal("planet_selected", self)
		Helpers.debug_print("planet selected")
func _process(delta):
	$PhysicsView/VelocityArrow.tip = linear_velocity
	$PhysicsView/GravForceArrow.tip = gravity_force
	$PhysicsView/CanvasLayer/Label.rect_position = get_canvas_transform().xform(self.position)
	$PhysicsView/CanvasLayer/Label.text = visible_text % [linear_velocity.length(), gravity_force.length(), self.mass]
func show_physics():
	$PhysicsView.show()
	$PhysicsView/CanvasLayer/Label.show()
func hide_physics():
	$PhysicsView.hide()
	$PhysicsView/CanvasLayer/Label.hide()