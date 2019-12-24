extends "res://gui/tools/planet creation/PlanetCreator.gd"
"""
This is a tool to create a planet giving three initial conditions:
Position, velocity and radius
Each of them can be set with a dynamic, editable preview of the planet
"""

enum State{INITIAL, EDITING}

var current_state = State.INITIAL

onready var velocity_handle = $Center/VelocityHandle
onready var radius_handle = $Center/RadiusHandle
onready var center = $Center

var radius_offset: Vector2 = Vector2(20,0)
var velocity_offset: Vector2 = Vector2(0,20)



func next_current_state():
	current_state = (current_state + 1) % State.size()
	match current_state:
		State.INITIAL:
			hide()
		State.EDITING:
			show()
	

func set_center(new_pos: Vector2):
	center.position = new_pos
func set_radius_point(new_radius_point: Vector2):
	radius_handle.tip = new_radius_point
func set_velocity_point(new_velocity_point: Vector2):
	velocity_handle.tip = new_velocity_point
func get_velocity():
	return velocity_handle.tip
func get_radius():
	return radius_handle.tip.length()
	
	
func handle_input(event):
	if event.is_action_pressed("leftMouseClick"):
		if current_state == State.INITIAL:
			set_center(get_global_mouse_position())
			set_radius_point(radius_offset)
			set_velocity_point(velocity_offset)
			next_current_state()
	if event.is_action_released("leftMouseClick"):
		center.being_dragged = false
	if event.is_action_pressed("confirm"):
		if current_state == State.EDITING:
			var inv_transform = get_viewport().canvas_transform.affine_inverse()
			planet_position = inv_transform.xform(center.position)
			planet_velocity = inv_transform.basis_xform(get_velocity())
			planet_radius = inv_transform.get_scale().x*get_radius()
			create_planet()
			next_current_state()
func reset():
	current_state = State.INITIAL
	match current_state:
		State.INITIAL:
			hide()
		State.EDITING:
			show()

func _draw():
	var points_circle = GeometryMath.generate_circle(32, center.position, get_radius())
	if current_state == State.EDITING:
		draw_polyline(points_circle, Color(255,0,0))
func _process(delta):
	update()
	if center.being_dragged:
		var mouse_pos = get_global_mouse_position()
		set_center(mouse_pos)
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick") and State.EDITING:
		center.being_dragged = true
