tool
extends Node2D

export var origin = Vector2(0,0)
export var tip = Vector2(1,0) setget set_tip
export var color = Color(0,255,0)

var dragMouse = false

const headLength = 10.0

func _ready():
	$Area2D.position = tip
func set_tip(newTip):
	tip = newTip
	$Area2D.position = tip

func _draw():
	var direction = (tip - origin).normalized()
	var head = PoolVector2Array([tip + sin(PI/3)*direction*headLength, tip + 0.5*direction.rotated(PI/2)*headLength, tip + 0.5*direction.rotated(-PI/2)*headLength,tip + sin(PI/3)*direction*headLength])
	draw_line(origin, tip, color)
	draw_polyline(head, color)
func _process(delta):
	update()
	if dragMouse:
		tip = get_global_mouse_position() - get_parent().position
		$Area2D.position = tip
func as_vector():
	return tip - position

func _unhandled_input(event):
	if event.is_action_released("leftMouseClick"):
		dragMouse = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick"):
		dragMouse = true
