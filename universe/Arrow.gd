tool
extends Node2D

export var origin = Vector2(0,0)
export var tip = Vector2(1,0)
export var color = Color(0,255,0)

const headLength = 10.0

func _draw():
	var direction = (tip - origin).normalized()
	var arrowHead = PoolVector2Array([tip + sin(PI/3)*direction*headLength, tip + 0.5*direction.rotated(PI/2)*headLength, tip + 0.5*direction.rotated(-PI/2)*headLength,tip + sin(PI/3)*direction*headLength])
	draw_line(origin, tip, color)
	draw_polyline(arrowHead, color)
func _process(delta):
	update()