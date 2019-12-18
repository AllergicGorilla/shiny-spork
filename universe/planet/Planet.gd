tool
extends Node2D
export var radius = 10
"""
func _ready():
	$VelocityVector.to = $Body.linear_velocity
func _process(delta):
	$VelocityVector.to = $Body.linear_velocity
	$VelocityVector.position = $Body.position
	$ForceVector.to = $Body.gravityForce
	$ForceVector.position = $Body.position
	update()

func _draw():
	draw_circle($Body.position, radius, Color(255,0,0))
"""