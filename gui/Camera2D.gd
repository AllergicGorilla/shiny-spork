extends Camera2D

const speed = 200.0
const unit = Vector2(1.0,1.0)
var zoomFactor = 1.0
const zoomDelta = 0.05
func _ready():
	zoom = zoomFactor*unit

func _process(delta):
	if current:
		if Input.is_action_pressed("camera_up"):
			position.y -= speed*delta
		if Input.is_action_pressed("camera_down"):
			position.y += speed*delta
		if Input.is_action_pressed("camera_right"):
			position.x += speed*delta
		if Input.is_action_pressed("camera_left"):
			position.x -= speed*delta
func _input(event):
	if event.is_action_pressed("camera_reset_zoom"):
		zoomFactor = 1.0
	if event.is_action_pressed("mouse_scroll_up"):
		zoomFactor -= zoomDelta
	elif event.is_action_pressed("mouse_scroll_down"):
		zoomFactor += zoomDelta
	zoomFactor = clamp(zoomFactor, 0.01, 10.0)
	zoom = zoomFactor * unit

