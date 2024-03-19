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
	current_state.do_state()

func set_my_enemy_body(body : Enemy) -> void:
	my_body = body
	patrolling_state.my_body = body
	combat_state.my_body = body
	searching_state.my_body = body

func to_searching_state(searching_position : Vector2) -> void:
	current_state = searching_state
	current_state.last_player_position = searching_position
