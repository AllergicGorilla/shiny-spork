extends Node

onready var universe = $Universe
onready var tools = $Tools
onready var createPlanetTool = $CreatePlanetTool
onready var clickAndDragPlanetCreator = $GUILayer/GUI/ClickAndDragPlanetCreator
onready var threeStepsPlanetCreator = $GUILayer/GUI/ThreeStepsPlanetCreator

func _ready():
	createPlanetTool.connect("planet_created",self,"_on_planet_created")
	
func _unhandled_input(event):
	if tools.current == tools.TOOL.createPlanet:
		if tools.mode == tools.PLANET_CREATION_MODE.clickAndDrag:
			clickAndDragPlanetCreator.handle_input(event)
		elif tools.mode == tools.PLANET_CREATION_MODE.threeSteps:
			threeStepsPlanetCreator.handle_input(event)

#SIGNAL HANDLING
func _on_planet_created(newPlanet):
	newPlanet.add_to_group("planets")
	universe.add_child(newPlanet)
	newPlanet.connect("planet_selected", self, "_on_planet_selected")
func _on_planet_selected(planet):
	tools.currentPlanet = planet
func _on_ClickAndDrag_pressed():
	tools.mode = tools.PLANET_CREATION_MODE.clickAndDrag
	threeStepsPlanetCreator.initialize()
func _on_ThreeSteps_pressed():
	tools.mode = tools.PLANET_CREATION_MODE.threeSteps
	clickAndDragPlanetCreator.initialize()
func _on_peekPhysics_pressed():
	Globals.VIEWPHYSICS = !Globals.VIEWPHYSICS
	print(Globals.VIEWPHYSICS)
	if Globals.VIEWPHYSICS:
		get_tree().call_group("planets", "show_physics")
	else:
		get_tree().call_group("planets", "hide_physics")