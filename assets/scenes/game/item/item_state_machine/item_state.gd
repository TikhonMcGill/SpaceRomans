extends Node

class_name ItemState

##Base Class for an Enemy item in the State Machine

var my_body : Item ##The Body of the item, which will be moved in the State

##Do the State of the Enemy
func do_state(delta : float) -> void:
	pass
