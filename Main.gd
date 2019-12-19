extends Node

onready var universe = $Universe
onready var tools = $Tools
onready var createPlanetTool = $CreatePlanetTool

func _ready():
	tools.connect("currentPlanet_changed",$PlanetLabel,"_on_currentPlanet_changed")
	createPlanetTool.connect("planet_created",self,"_on_planet_created")
func _on_planet_created(newPlanet):
	newPlanet.add_to_group("planets")
	universe.add_child(newPlanet)
	newPlanet.connect("planet_selected", self, "_on_planet_selected")
func _on_planet_selected(planet):
	tools.currentPlanet = planet