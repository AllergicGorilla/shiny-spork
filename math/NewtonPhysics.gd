class_name Newton
const G = 500000.0
#Represents force applied on M1
#therefore the distance vector must point from M2 to M1
static func gravitational_force(m1:float , m2: float, distance_vec: Vector2) -> Vector2:
	var distance : float = distance_vec.length()
	return -(G*m1*m2/(distance*distance*distance))*distance_vec