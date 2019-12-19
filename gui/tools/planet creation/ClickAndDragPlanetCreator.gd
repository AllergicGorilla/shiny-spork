extends Node2D

enum STATE{free, dragging}

var state = STATE.free
var center: Vector2 setget set_center
var velocityPoint: Vector2 setget set_velocity_point

onready var createPlanetTool = get_node("/root/Main/CreatePlanetTool")

func next_state():
	state = (state + 1) % STATE.size()
	match state:
		STATE.free:
			$VelocityArrow.hide()
		STATE.dragging:
			$VelocityArrow.show()
	

func set_center(newCenter: Vector2):
	center = newCenter
	$VelocityArrow.origin = center
func set_velocity_point(newVelocityPoint: Vector2):
	velocityPoint = newVelocityPoint
	$VelocityArrow.tip = velocityPoint
func get_velocity():
	return $VelocityArrow.tip - center
	
	
func handle_input(event, tools):
	if event.is_action_pressed("leftMouseClick"):
		if state == STATE.free:
			set_center(get_global_mouse_position())
			set_velocity_point(get_global_mouse_position())
			next_state()
			$VelocityArrow.show()
	elif event.is_action_released("leftMouseClick"):
		if state == STATE.dragging:
			$VelocityArrow.hide()
			set_velocity_point(get_global_mouse_position())
			createPlanetTool.create_planet(tools.gui_to_world_pos(center), get_velocity())
			next_state()
	elif event is InputEventMouseMotion:
		if state == STATE.dragging:
			set_velocity_point(get_global_mouse_position())

func _draw():
	var color = createPlanetTool.newPlanetColor
	var points_circle = GeometryMath.generate_circle(32, center, createPlanetTool.newRadius)
	if state == STATE.dragging:
		draw_polyline(points_circle, color)
func _process(delta):
	update()
