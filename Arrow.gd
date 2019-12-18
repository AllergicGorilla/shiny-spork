tool
extends Node2D

export var origin = Vector2(0,0)
export var vec = Vector2(1,0)
export var color = Color(0,255,0)

const headLength = 10.0

func _draw():
	var direction = (vec - origin).normalized()
	var arrowHead = PoolVector2Array([vec + sin(PI/3)*direction*headLength, vec + 0.5*direction.rotated(PI/2)*headLength, vec + 0.5*direction.rotated(-PI/2)*headLength,vec + sin(PI/3)*direction*headLength])
	draw_line(origin, vec, color)
	draw_polyline(arrowHead, color)
func _process(delta):
	update()