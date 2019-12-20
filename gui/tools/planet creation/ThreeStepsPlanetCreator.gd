extends Node2D

signal new_planet_requested

enum STATE{initial, editing}

var state = STATE.initial

onready var VelocityHandle = $VelocityHandle
onready var RadiusHandle = $RadiusHandle
onready var CenterHandle = $CenterHandle

var radiusOffset: Vector2 = Vector2(20,0)
var velocityOffset: Vector2 = Vector2(0,20)

#This is a tool to create a planet giving three initial conditions:
#Position, velocity and radius
#Each of them can be set within an editable preview of the planet


func _unhandled_input(event):
	handle_input(event)

func next_state():
	state = (state + 1) % STATE.size()
	match state:
		STATE.initial:
			hide()
		STATE.editing:
			show()
	

func set_center(center: Vector2):
	RadiusHandle.origin = center
	VelocityHandle.origin = center
	CenterHandle.position = center
func set_radius_point(newRadiusPoint: Vector2):
	RadiusHandle.tip = newRadiusPoint
func set_velocity_point(newVelocityPoint: Vector2):
	VelocityHandle.tip = newVelocityPoint
func get_velocity():
	return VelocityHandle.tip - CenterHandle.position
func get_radius():
	return (RadiusHandle.tip - CenterHandle.position).length()
	
	
func handle_input(event):
	if event.is_action_pressed("leftMouseClick"):
		if state == STATE.initial:
			set_center(get_global_mouse_position())
			set_radius_point(get_global_mouse_position() + radiusOffset)
			set_velocity_point(get_global_mouse_position() + velocityOffset)
			next_state()
	if event.is_action_released("leftMouseClick"):
		CenterHandle.dragMouse = false
	if event.is_action_pressed("ui_accept"):
		emit_signal("new_planet_requested", CenterHandle.position, get_velocity(), get_radius())
		next_state()

func _draw():
	var points_circle = GeometryMath.generate_circle(32, CenterHandle.position, get_radius())
	if state == STATE.editing:
		draw_polyline(points_circle, Color(255,0,0))
func _process(delta):
	update()
	if CenterHandle.dragMouse:
		var mousePos = get_global_mouse_position()
		set_center(mousePos)
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick") and STATE.editing:
		CenterHandle.dragMouse = true
