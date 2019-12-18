class_name GeometryMath
static func generate_circle(nb_points: int, center: Vector2, radius: float) -> PoolVector2Array:
	var points_circle = PoolVector2Array()
	var angle = 2*PI/nb_points
	for i in range(nb_points+1):
		var point = center + Vector2(radius*cos(i*angle), radius*sin(i*angle))
		points_circle.push_back(point)
	return points_circle