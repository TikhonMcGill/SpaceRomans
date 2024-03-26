extends EnemyState

class_name SearchingState

signal search_completed

@onready var wait_timer: Timer = $WaitTimer

var search_position : Vector2 = -Vector2.ONE

var enemy_vision : PlayerSeer

func _can_search() -> bool:
	return search_position.x >= 0

func _get_direction_to_search() -> float:
	return my_body.global_position.angle_to_point(search_position)

func do_state(delta : float) -> void:
	if _can_search() == true:
		if my_body.global_position.distance_to(search_position) <= 8 and wait_timer.time_left == 0:
			wait_timer.start()
			return
		elif my_body.global_position.distance_to(search_position) > 8:
			wait_timer.stop()
		
		if wait_timer.time_left == 0:
			my_body.velocity = my_body.global_position.direction_to(search_position) * 200
			my_body.move_and_slide()

func _on_wait_timer_timeout() -> void:
	my_body.velocity = Vector2.ZERO
	search_completed.emit()
