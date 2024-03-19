extends EnemyState

class_name SearchingState

var last_player_position : Vector2 = -Vector2.ONE

var enemy_vision : PlayerSeer

func _can_search() -> bool:
	return last_player_position.x >= 0

func _get_direction_to_search() -> float:
	return my_body.global_position.angle_to_point(last_player_position)

func do_state() -> void:
	if _can_search() == true:
		var desired_angle := _get_direction_to_search()
		if enemy_vision.rotation != desired_angle:
			enemy_vision.rotation = lerp_angle(enemy_vision.rotation,desired_angle,0.05)
