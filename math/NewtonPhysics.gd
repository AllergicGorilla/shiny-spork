class_name Newton
const G = 500000.0
#Represents force applied on M1
#therefore the distance vector must point from M2 to M1
static func gravitational_force(M1:float , M2: float, distanceVec: Vector2) -> Vector2:
	var distance : float = distanceVec.length()
	return -(G*M1*M2/(distance*distance*distance))*distanceVec