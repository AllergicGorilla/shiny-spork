extends Node2D

enum STATE{initial, setRadius, setVelocity}

signal planet_created

onready var Planet = preload("res://universe/planet/Planet.tscn")
var state = STATE.initial
var center: Vector2 setget set_center
var radiusPoint: Vector2 setget set_radius_point
var velocityPoint: Vector2 setget set_velocity_point
var newPlanetColor = Color(255,0,0)
var newMass = 1.0

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
		print(state)
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
				#CREATE PLANET#
				var planet = Planet.instance()
				var body = planet.get_node("Body")
				body.mass = newMass
				body.color = newPlanetColor
				body.position = center
				body.linear_velocity = get_velocity()
				body.radius = get_radius()
				emit_signal("planet_created", planet)
				next_state()
	elif event is InputEventMouseMotion:
		match state:
			STATE.setRadius:
				set_radius_point(get_global_mouse_position())
			STATE.setVelocity:
				set_velocity_point(get_global_mouse_position())

func _draw():
	var points_circle = PoolVector2Array()
	var nb_points = 32
	var angle = 2*PI/nb_points
	var radius = get_radius()
	for i in range(nb_points+1):
		var point = center + Vector2(radius*cos(i*angle), radius*sin(i*angle))
		points_circle.push_back(point)
	if state == STATE.setRadius or state == STATE.setVelocity:
		draw_polyline(points_circle, Color(255,0,0))
func _process(delta):
	update()
	
func _on_mass_entered(mass):
	newMass = mass
func _on_color_entered(color):
	newPlanetColor = color





