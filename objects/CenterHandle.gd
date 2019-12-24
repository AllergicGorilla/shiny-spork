tool
extends Position2D

export var being_dragged = false


func _draw():
	var points_circle = GeometryMath.generate_circle(32, Vector2(0,0), 10.0)
	draw_polyline(points_circle, Color(255,255,0))
func _process(delta):
	update()
	if being_dragged:
		position = get_parent().get_global_mouse_position()

func _unhandled_input(event):
	if event.is_action_released("leftMouseClick"):
		being_dragged = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick"):
		being_dragged = true
