extends EnemyState

class_name CombatState

@onready var shoot_timer: Timer = $ShootTimer
@onready var shoot_cast: RayCast2D = $ShootCast


var target : Player = null

func do_state(delta : float) -> void:
	if target == null:
		shoot_cast.enabled = false
		return
	
	shoot_cast.global_position = my_body.global_position
	
	my_body.look_at_point(target.global_position)
	shoot_cast.enabled = true
	shoot_cast.target_position = target.global_position - shoot_cast.global_position

func _on_shoot_timer_timeout() -> void:
	print("Shot!")
	if shoot_cast.is_colliding() == true:
		target.player_health -= my_body.enemy_damage
