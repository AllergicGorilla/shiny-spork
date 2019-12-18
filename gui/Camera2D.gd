extends Camera2D

onready var tools = get_node("/root/Tools")
onready var Body = tools.currentPlanetBody

const speed = 200.0

func _ready():
	tools.connect("currentPlanetBody_changed",self,"_on_currentPlanetBody_changed")

func _process(delta):
	if tools.current == tools.TOOL.followPlanet && is_instance_valid(Body):
		position = Body.position
	else:
		if Input.is_action_pressed("camera_up"):
			position.y -= speed*delta
		if Input.is_action_pressed("camera_down"):
			position.y += speed*delta
		if Input.is_action_pressed("camera_right"):
			position.x += speed*delta
		if Input.is_action_pressed("camera_left"):
			position.x -= speed*delta
func _on_currentPlanetBody_changed():
	Body = tools.currentPlanetBody
