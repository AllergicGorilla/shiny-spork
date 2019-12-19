extends Node2D

enum STATE{initial, setRadius, setVelocity}

var state = STATE.initial
var center: Vector2 setget set_center
var radiusPoint: Vector2 setget set_radius_point
var velocityPoint: Vector2 setget set_velocity_point
var newPlanetColor = Color(255,0,0)
var newMass = 1.0

onready var tools = get_node("/root/Tools")
onready var createPlanetTool = get_node("/root/CreatePlanetTool")

func _unhandled_input(event):
	#The create planet tool will create a planet given
	#a starting position,radius and initial velocity,
	#all given by consecutive mouse clicks
	if tools.current == tools.TOOL.createPlanet:
		handle_input(event)

func next_state():
	state = (state + 1) % STATE.size()
	match state:
		STATE.initial:
			$VelocityArrow.hide()
			$RadiusArrow.hide()
		STATE.setRadius:
			$RadiusArrow.show()
		STATE.setVelocity:
			$VelocityArrow.show()
	

func set_center(newCenter: Vector2):
	center = newCenter
	$RadiusArrow.origin = center
	$VelocityArrow.origin = center
func set_radius_point(newRadiusPoint: Vector2):
	radiusPoint = newRadiusPoint
	$RadiusArrow.tip = radiusPoint
func set_velocity_point(newVelocityPoint: Vector2):
	velocityPoint = newVelocityPoint
	$VelocityArrow.tip = velocityPoint
func get_velocity():
	return $VelocityArrow.tip - center
func get_radius():
	return (radiusPoint - center).length()
	
	
func handle_input(event):
	#This is game logic to display arrows (representing either the starting radius or velocity)
	#whenever the player clicks and moves their mouse
	#during the creation of a new Planet
	#First click: sets the initial position
	#Second click: sets the radius
	#Third click: sets the velocity
	if event.is_action_pressed("leftMouseClick"):
		match state:
			STATE.initial:
				set_center(get_global_mouse_position())
				set_radius_point(get_global_mouse_position())
				next_state()
			STATE.setRadius:
				set_radius_point(get_global_mouse_position())
				set_velocity_point(get_global_mouse_position())
				next_state()
			STATE.setVelocity:
				set_velocity_point(get_global_mouse_position())
				createPlanetTool.create_planet(center, get_velocity(), get_radius())
				next_state()
	elif event is InputEventMouseMotion:
		match state:
			STATE.setRadius:
				set_radius_point(get_global_mouse_position())
			STATE.setVelocity:
				set_velocity_point(get_global_mouse_position())

func _draw():
	var points_circle = GeometryMath.generate_circle(32, center, get_radius())
	if state == STATE.setRadius or state == STATE.setVelocity:
		draw_polyline(points_circle, Color(255,0,0))
func _process(delta):
	update()
