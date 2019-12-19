extends Label
onready var tools = get_node("/root/Tools")
onready var Body = tools.currentPlanetBody

var mainText = "Speed: %.2f, Force: %.2f"

func _ready():
	tools.connect("currentPlanetBody_changed",self,"_on_currentPlanetBody_changed")
func _process(delta):
	update_text()

func update_text():
	if (is_instance_valid(Body)):
		var v = Body.linear_velocity.length()
		var f = Body.gravityForce.length()
		text = mainText % [v,f]
		rect_position = Body.position

func _on_currentPlanetBody_changed():
	Body = tools.currentPlanetBody
	if (is_instance_valid(Body)):
		show()
	else:
		hide()
