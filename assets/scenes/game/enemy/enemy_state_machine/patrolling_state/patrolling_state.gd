extends EnemyState

class_name PatrollingState

@export var patrol_points : Array[PatrolPoint] = []

var completed_patrol_points : Array[PatrolPoint] = []

var back_and_forth : bool = false

func _get_next_patrol_point() -> PatrolPoint:
	for p in patrol_points:
		if completed_patrol_points.has(p) == false:
			return p
	
	if back_and_forth == true:
		patrol_points.reverse()
	
	completed_patrol_points = []
	return patrol_points[0]

func _move_to_patrol_point(delta : float) -> void:
	var next_point := _get_next_patrol_point()
	if len(patrol_points) > 1 and my_body.global_position.distance_to(next_point.global_position) < 2:
		completed_patrol_points.append(next_point)
		return
	
	my_body.velocity = my_body.global_position.direction_to(next_point.global_position) * my_body.enemy_patrol_speed
	my_body.move_and_slide()

func _look_around(delta : float) -> void:
	my_body.enemy_vision.rotate(get_physics_process_delta_time())

func do_state(delta : float) -> void:
	if len(patrol_points) == 0:
		_look_around(delta)
	elif len(patrol_points) == 1:
		if my_body.global_position.distance_to(_get_next_patrol_point().global_position) > 2:
			_move_to_patrol_point(delta)
		else:
			my_body.velocity = Vector2.ZERO
			_look_around(delta)
	else:
		_move_to_patrol_point(delta)
