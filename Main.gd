extends Node

onready var universe = $Universe
onready var tools = $GUILayer/GUI/Tools
onready var createPlanetTool = $GUILayer/GUI/Tools/CreatePlanetTool
onready var clickAndDragPlanetCreator = $GUILayer/GUI/Tools/CreatePlanetTool/ClickAndDragPlanetCreator
onready var threeStepsPlanetCreator = $GUILayer/GUI/Tools/CreatePlanetTool/ThreeStepsPlanetCreator

func _ready():
	createPlanetTool.connect("planet_created",self,"_on_planet_created")
	
func _unhandled_input(event):
	if tools.currentState == tools.TOOL.createPlanet:
		if createPlanetTool.mode == createPlanetTool.PLANET_CREATION_MODE.clickAndDrag:
			clickAndDragPlanetCreator.handle_input(event)
		elif createPlanetTool.mode == createPlanetTool.PLANET_CREATION_MODE.threeSteps:
			threeStepsPlanetCreator.handle_input(event)

#SIGNAL HANDLING
func _on_planet_created(newPlanet):
	newPlanet.add_to_group("planets")
	universe.add_child(newPlanet)
	newPlanet.connect("planet_selected", self, "_on_planet_selected")
func _on_planet_selected(planet):
	tools.currentPlanet = planet
