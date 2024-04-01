extends Node

class_name ItemStateMachine

##Class handling the State Machine of the Enemy


enum STATE{ ##The Possible States of the Enemy
			PATROL, ##The Enemy is patrolling
			SEARCH, ##The Enemy is searching for the player
			COMBAT ##The Enemy is fighting the player
		} 

var current_state : ItemState
var my_body : CharacterBody2D = null

#func _ready() -> void:


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.do_state(delta)

func set_my_item_body(body : Item) -> void:
	my_body = body

