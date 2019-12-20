extends Node2D

signal new_planet_requested

enum STATE{free, dragging}

var state = STATE.free
var center: Vector2 setget set_center
var velocityPoint: Vector2 setget set_velocity_point

onready var createPlanetTool = get_parent()

func next_state():
	state = (state + 1) % STATE.size()
	match state:
		STATE.free:
			hide()
		STATE.dragging:
			show()
	

func set_center(newCenter: Vector2):
	center = newCenter
	$VelocityArrow.origin = center
func set_velocity_point(newVelocityPoint: Vector2):
	velocityPoint = newVelocityPoint
	$VelocityArrow.tip = velocityPoint
func get_velocity():
	return $VelocityArrow.tip - center
	
	
func handle_input(event):
	if event.is_action_pressed("leftMouseClick"):
		if state == STATE.free:
			set_center(get_global_mouse_position())
			set_velocity_point(get_global_mouse_position())
			next_state()
			show()
	elif event.is_action_released("leftMouseClick"):
		if state == STATE.dragging:
			set_velocity_point(get_global_mouse_position())
			var canvasTransform = get_viewport().canvas_transform.affine_inverse()
			emit_signal("new_planet_requested", canvasTransform.xform(center),
				canvasTransform.basis_xform(get_velocity()), canvasTransform.get_scale().x*createPlanetTool.newRadius)
			next_state()
	elif event is InputEventMouseMotion:
		if state == STATE.dragging:
			set_velocity_point(get_global_mouse_position())

func initialize():
	state = STATE.free
	match state:
		STATE.free:
			hide()
		STATE.dragging:
			show()

func _draw():
	var color = createPlanetTool.newPlanetColor
	var points_circle = GeometryMath.generate_circle(32, center, createPlanetTool.newRadius)
	if state == STATE.dragging:
		draw_polyline(points_circle, color)
func _process(delta):
	update()
