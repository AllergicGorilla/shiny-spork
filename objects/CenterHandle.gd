tool
extends Position2D

export var dragMouse = false


func _draw():
	var posHandle_circle = GeometryMath.generate_circle(32, Vector2(0,0), 10.0)
	draw_polyline(posHandle_circle, Color(255,255,0))
func _process(delta):
	update()
	if dragMouse:
		position = get_parent().get_global_mouse_position()

func _unhandled_input(event):
	if event.is_action_released("leftMouseClick"):
		dragMouse = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick"):
		dragMouse = true
