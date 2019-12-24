tool
extends Node2D

export var origin = Vector2(0,0)
export var tip = Vector2(1,0)
export var color = Color(0,255,0)

const head_length = 10.0

func _draw():
	var direction = as_vector().normalized()
	var arrow_head = PoolVector2Array([tip + sin(PI/3)*direction*head_length, tip + 0.5*direction.rotated(PI/2)*head_length, tip + 0.5*direction.rotated(-PI/2)*head_length,tip + sin(PI/3)*direction*head_length])
	draw_line(origin, tip, color)
	draw_polyline(arrow_head, color)
func _process(delta):
	update()
func as_vector():
	return tip - origin