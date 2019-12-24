extends "res://gui/tools/planet creation/PlanetCreator.gd"

enum State{FREE, DRAGGING}

var current_state = State.FREE
var preview_position: Vector2

onready var velocity_arrow = $VelocityArrow

func next_state():
	current_state = (current_state + 1) % State.size()
	match current_state:
		State.FREE:
			hide()
		State.DRAGGING:
			show()
	

func set_center(new_center: Vector2):
	preview_position = new_center
	velocity_arrow.origin = new_center
func set_velocity_point(new_velocity_point: Vector2):
	velocity_arrow.tip = new_velocity_point
func get_velocity():
	return velocity_arrow.as_vector()
	
	
func handle_input(event):
	if event.is_action_pressed("leftMouseClick"):
		if current_state == State.FREE:
			set_center(get_global_mouse_position())
			set_velocity_point(get_global_mouse_position())
			next_state()
			show()
	elif event.is_action_released("leftMouseClick"):
		if current_state == State.DRAGGING:
			set_velocity_point(get_global_mouse_position())
			var inv_transform = get_viewport().canvas_transform.affine_inverse()
			planet_position = inv_transform.xform(preview_position)
			planet_velocity = inv_transform.basis_xform(get_velocity())
			#planet_radius = inv_transform.get_scale().x*preview_radius
			create_planet()
			next_state()
	elif event is InputEventMouseMotion:
		if current_state == State.DRAGGING:
			set_velocity_point(get_global_mouse_position())

func reset():
	current_state = State.FREE
	match current_state:
		State.FREE:
			hide()
		State.DRAGGING:
			show()

func _draw():
	var preview_radius = get_viewport().canvas_transform.get_scale().x*planet_radius
	var points_circle = GeometryMath.generate_circle(32, preview_position, preview_radius)
	if current_state == State.DRAGGING:
		draw_polyline(points_circle, planet_color)
func _process(delta):
	update()


