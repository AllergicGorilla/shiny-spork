extends Node2D

func _physics_process(delta):
	#N-body gravitation
	var planets = get_tree().get_nodes_in_group("planets")
	var ships = get_tree().get_nodes_in_group("ships")
	for p1 in planets:
		var gravForce = Vector2(0,0)
		for p2 in planets:
			if p1 != p2:
				var distanceVec = p1.get_position() - p2.get_position()
				gravForce += Newton.gravitational_force(p1.mass, p2.mass, distanceVec)
		p1.gravity_force = gravForce
	for s in ships:
		var final_force = Vector2(0,0)
		for p1 in planets:
			var distanceVec = s.get_position() - p1.get_position()
			final_force += Newton.gravitational_force(s.mass, p1.mass, distanceVec)
		s.gravity_force = final_force

#func _on_Area2D_body_exited(body):
	#body.get_parent().queue_free()

