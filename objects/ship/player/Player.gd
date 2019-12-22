extends Node2D

func _on_Ship_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftMouseClick"):
		print("HEY MOOM!")
onready var target = $Target
onready var ship = $Ship
export var torque_percentage = 1.0
export var thrust_percentage = 1.0
func _ready():
	ship.routine = ship.ROUTINE.free
	$Ship2.target_body = ship
	$Ship2.routine = ship.ROUTINE.approach_body

func _input(event):
	#if event.is_action_pressed("leftMouseClick"):
	#	target.position = get_global_mouse_position()
	if event.is_action_pressed("toggle_ship_angular_damping"):
		ship.toggle_angular_damping()
	if event.is_action_pressed("player_manual_control"):
		ship.routine = ship.ROUTINE.free
	if event.is_action_pressed("player_look_at_target"):
		ship.routine = ship.ROUTINE.look_at_target
	if event.is_action_pressed("player_match_desired_velocity"):
		ship.routine = ship.ROUTINE.match_desired_velocity
	if event.is_action_pressed("player_match_body_velocity"):
		ship.routine = ship.ROUTINE.match_body_velocity
	if event.is_action_pressed("player_shoot_at_body"):
		ship.routine = ship.ROUTINE.shoot_at_body
func _unhandled_input(event):
	if event.is_action_pressed("leftMouseClick"):
		target.position = get_global_mouse_position()
func _process(delta):
	var final_torque = 0.0
	var final_thrust = 0.0
	if ship.routine == ship.ROUTINE.free:
		if Input.is_action_pressed("player_thrust"):
			final_thrust += thrust_percentage
		if Input.is_action_pressed("player_turn_clockwise"):
			final_torque += torque_percentage
		if Input.is_action_pressed("player_turn_counterclockwise"):
			final_torque -= torque_percentage
	ship.set_torque(final_torque)
	ship.set_thrust(final_thrust)
	#if Input.is_action_pressed("leftMouseClick"):
	#	target.position = get_global_mouse_position()
	$Following/VelocityArrow.tip = ship.linear_velocity
	$Following/TargetdV.tip = ship.target_dV
	$Following/ShootVelocity.tip = ship.shoot_velocity
	ship.target = target.position - ship.position
	ship.desired_velocity = $Following/TargetVelocity.as_vector()
	
	$Following/ForceVector.tip = ship.gravity_force