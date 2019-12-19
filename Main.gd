extends Node

onready var universe = $Universe
onready var tools = $Tools
onready var createPlanetTool = $CreatePlanetTool

func _ready():
	createPlanetTool.connect("planet_created",self,"_on_planet_created")
func _unhandled_input(event):
	if tools.current == tools.TOOL.createPlanet:
		if tools.mode == tools.PLANET_CREATION_MODE.clickAndDrag:
			$GUILayer/GUI/ClickAndDragPlanetCreator.handle_input(event, tools)
		elif tools.mode == tools.PLANET_CREATION_MODE.threeSteps:
			$GUILayer/GUI/ThreeStepsPlanetCreator.handle_input(event, tools)

#SIGNAL HANDLING
func _on_planet_created(newPlanet):
	newPlanet.add_to_group("planets")
	universe.add_child(newPlanet)
	newPlanet.connect("planet_selected", self, "_on_planet_selected")
func _on_planet_selected(planet):
	tools.currentPlanet = planet
func _on_ClickAndDrag_pressed():
	tools.mode = tools.PLANET_CREATION_MODE.clickAndDrag
func _on_ThreeSteps_pressed():
	tools.mode = tools.PLANET_CREATION_MODE.threeSteps
func _on_ColorPicker_color_changed(color):
	pass # Replace with function body.
