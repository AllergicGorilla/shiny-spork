extends Node2D

enum STATE{free, dragging}

var state = STATE.free
var center: Vector2 setget set_center
var velocityPoint: Vector2 setget set_velocity_point

#func _unhandled_input(event):
#	handle_input(event)

func next_state():
	state = (state + 1) % STATE.size()
	match state:
		STATE.free:
			$Arrow.hide()
		STATE.dragging:
			$Arrow.show()

func set_center(newCenter: Vector2):
	center = newCenter
	$Arrow.origin = center
func set_velocity_point(newVelocityPoint: Vector2):
	velocityPoint = newVelocityPoint
	$Arrow.tip = velocityPoint
func get_velocity():
	return $Arrow.tip - center

func handle_input(event):
	if event.is_action_pressed("leftMouseClick"):
		if state == STATE.free:
			set_center(event.position)
			set_velocity_point(event.position)
			next_state()
			$Arrow.show()
	elif event.is_action_released("leftMouseClick"):
		if state == STATE.dragging:
			$Arrow.hide()
			set_velocity_point(event.position)
			next_state()
	elif event is InputEventMouseMotion:
		if state == STATE.dragging:
			set_velocity_point(event.position)
