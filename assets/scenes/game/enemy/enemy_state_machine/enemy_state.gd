extends Node

class_name EnemyState

##Base Class for an Enemy State in the State Machine

var my_body : Enemy ##The Body of the Enemy, which will be moved in the State

##Do the State of the Enemy
func do_state(delta : float) -> void:
	pass
