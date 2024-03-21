extends Node

class_name EnemyStateMachine

##Class handling the State Machine of the Enemy

@onready var patrolling_state: PatrollingState = $PatrollingState
@onready var combat_state: CombatState = $CombatState
@onready var searching_state: SearchingState = $SearchingState

enum STATE{ ##The Possible States of the Enemy
			PATROL, ##The Enemy is patrolling
			SEARCH, ##The Enemy is searching for the player
			COMBAT ##The Enemy is fighting the player
		} 

var current_state : EnemyState
var my_body : CharacterBody2D = null

func _ready() -> void:
	current_state = patrolling_state

func _physics_process(delta: float) -> void:
	current_state.do_state(delta)

func set_my_enemy_body(body : Enemy) -> void:
	my_body = body
	patrolling_state.my_body = body
	combat_state.my_body = body
	searching_state.my_body = body

func to_searching_state() -> void:
	current_state = searching_state

func to_patrolling_state() -> void:
	current_state = patrolling_state

func to_combat_state() -> void:
	print("TO COMBAT STATE!")
	current_state = combat_state
	combat_state.shoot_timer.start()

func _hear_player(hearing_position: Vector2) -> void:
	searching_state.search_position = hearing_position
	if current_state == patrolling_state:
		to_searching_state()

func _on_searching_state_search_completed() -> void:
	to_patrolling_state()

func _on_enemy_vision_player_seen(player: Player) -> void:
	if current_state != combat_state:
		combat_state.target = player
		to_combat_state()

func _on_enemy_vision_player_unseen(last_position: Vector2) -> void:
	if current_state == combat_state:
		combat_state.target = null
		combat_state.shoot_timer.stop()
		searching_state.search_position = last_position
		to_searching_state()
