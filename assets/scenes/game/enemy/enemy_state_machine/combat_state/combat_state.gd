extends EnemyState

class_name CombatState

@onready var shoot_timer: Timer = $ShootTimer
@onready var shoot_cast: RayCast2D = $ShootCast

@onready var laser: Line2D = $Laser

var target : Player = null

func do_state(delta : float) -> void:
	if target == null:
		_lose_target()
		return
	
	shoot_cast.global_position = my_body.global_position
	
	my_body.look_at_point(target.global_position)
	shoot_cast.enabled = true
	shoot_cast.target_position = target.global_position - shoot_cast.global_position
	
func _on_shoot_timer_timeout() -> void:
	if my_body.enemy_vision.can_see_player() == false:
		my_body.state_machine.searching_state.search_position = target.global_position
		my_body.state_machine.to_searching_state()
		_lose_target()
		return
	
	laser.points[0] = my_body.global_position + Vector2.ZERO
	laser.points[1] = my_body.global_position + shoot_cast.target_position
	
	laser.visible = true
	laser.modulate.a = 1.0
	var tween := create_tween()
	tween.tween_property(laser,"modulate:a",0,0.1)
	tween.tween_callback(laser.set_visible.bind(false))
	
	if shoot_cast.is_colliding() == true:
		target.player_health -= my_body.enemy_damage

func _lose_target() -> void:
	target = null
	shoot_cast.enabled = false
	shoot_timer.stop()
