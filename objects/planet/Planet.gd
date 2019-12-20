extends Node

signal planet_selected

var mainText = "Speed: %.2f, Force: %.2f"
onready var label = $Following/Label

func _ready():
	if Globals.VIEWPHYSICS:
		show_physics()
	else:
		hide_physics()

func _process(delta):
	update_text()

func update_text():
	var v = get_node("Body").linear_velocity.length()
	var f = get_node("Body").gravityForce.length()
	label.text = mainText % [v,f]

func _on_Body_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick"):
		emit_signal("planet_selected", self)
		Helpers.debug_print("planet selected")

func hide_physics():
	$Following.hide()
func show_physics():
	$Following.show()