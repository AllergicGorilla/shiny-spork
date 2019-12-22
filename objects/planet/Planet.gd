extends Node

signal planet_selected

var mainText = "Speed: %.2f, Force: %.2f"

export var mass: float = 1.0 setget set_mass
export var radius: float = 1.0
export var color: Color = Color.white
var gravityForce = Vector2(0,0)
onready var label = $Following/Label
onready var body = $Body

func _ready():
	if Globals.VIEWPHYSICS:
		show_physics()
	else:
		hide_physics()

func _process(delta):
	update_text()

func update_text():
	var v = get_node("Body").linear_velocity.length()
	var f = gravityForce.length()
	label.text = mainText % [v,f]

func _on_Body_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick"):
		emit_signal("planet_selected", self)
		Helpers.debug_print("planet selected")

func hide_physics():
	$Following.hide()
func show_physics():
	$Following.show()

func set_mass(new_mass):
	mass = new_mass
	if is_instance_valid(body):
		body.mass = new_mass