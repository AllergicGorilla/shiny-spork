extends RigidBody2D

enum ROUTINE{free, look_at_target, match_desired_velocity, match_body_velocity, shoot_at_body, approach_body}

export var length = 100.0
export var playable = false
var triangle
var gravity_force = Vector2(0,0)
const unit = Vector2(1,0)
export var max_acceleration = 100.0
export var max_angular_acceleration = 12.0
const maxAngularDamp = 4
const maxSpeed = 200.0
var routine = ROUTINE.free
var thrust = Vector2(0,0) setget set_thrust
var torque = 0.0 setget set_torque
var is_angular_damping_on setget set_is_angular_damping_on
var target_dV = Vector2(0,0)
var desired_velocity = Vector2(0,0)
var initial_velocity = Vector2(0,0)
var shoot_velocity = Vector2(0,0)

var target = Vector2(1,0) setget set_target
var target_body: RigidBody2D


func _ready():
	set_is_angular_damping_on(true)
	triangle = PoolVector2Array([length*unit, 0.5*length*unit.rotated(2*PI/3), 0.5*length*unit.rotated(4*PI/3),length*unit])
	$CollisionPolygon.polygon = triangle
	
func _draw():
	draw_polyline(triangle, Color.red)
func _process(delta):
	#Resets calculated torques and forces back to zero
	#If it's the player ship, you must do this after the input handling
	if !playable:
		set_thrust(0.0)
		set_torque(0.0)
	update()
func _integrate_forces(state):
	var direction = transform.x
	#Look at target
	match routine:
		ROUTINE.look_at_target:
			aim_at(target)
		ROUTINE.match_desired_velocity:
			reach_velocity(desired_velocity)
		ROUTINE.match_body_velocity:
			match_body_velocity(target_body)
		ROUTINE.shoot_at_body:
			shoot_at_body(target_body)
		ROUTINE.approach_body:
			approach_body(target_body)
	
	set_applied_force(thrust + gravity_force)
	set_applied_torque(torque)
func current_dV():
	return linear_velocity - initial_velocity
func aim_at(vector):
	var direction = transform.x
	torque = -inertia*max_angular_acceleration*vector.angle_to(direction)
func match_body_velocity(body):
	assert(is_instance_valid(body))
	reach_velocity(body.linear_velocity)
func reach_velocity(v):
	target_dV = v - linear_velocity
	reach_dV(target_dV)
func shoot_at_body(body):
	assert(is_instance_valid(body))
	var body_direction = (body.position - position).normalized()
	var dV = maxSpeed*body_direction - linear_velocity + body.linear_velocity
	shoot_velocity = dV
	var direction = transform.x
	var angle_to_target_dV = dV.angle_to(direction)
	if dV.length() > 5.0:
		torque = -inertia*max_angular_acceleration*angle_to_target_dV
		if abs(angle_to_target_dV) < PI/12:
			set_thrust(1.0)
func approach_body(body):
	assert(is_instance_valid(body))
	var distance = (body.position - position).length()
	var speed = 0.0
	if distance < 500.0:
		speed = 0
	else:
		speed = maxSpeed
	var body_direction = (body.position - position).normalized()
	var dV = speed*body_direction - linear_velocity + body.linear_velocity
	shoot_velocity = dV
	var direction = transform.x
	var angle_to_target_dV = dV.angle_to(direction)
	if dV.length() > 5.0:
		torque = -inertia*max_angular_acceleration*angle_to_target_dV
		if abs(angle_to_target_dV) < PI/12:
			set_thrust(1.0)
func reach_dV(dV):
	var direction = transform.x
	var angle_to_target_dV = dV.angle_to(direction)
	if dV.length() > 5.0:
		torque = -inertia*max_angular_acceleration*angle_to_target_dV
		if abs(angle_to_target_dV) < PI/12:
			set_thrust(0.5)
	else:
		aim_at(linear_velocity)

func set_thrust(intensity):
	assert(intensity >= 0.0 and intensity <= 1.0)
	thrust = intensity*mass*max_acceleration*get_transform().x
func set_torque(intensity):
	assert(intensity >= -1.0 and intensity <= 1.0)
	torque = intensity*inertia*max_angular_acceleration

func set_is_angular_damping_on(new):
	is_angular_damping_on = new
	if is_angular_damping_on:
		angular_damp = maxAngularDamp
	else:
		angular_damp = 0.0
func toggle_angular_damping():
	set_is_angular_damping_on(!is_angular_damping_on)
func set_target(newTarget):
	target = newTarget