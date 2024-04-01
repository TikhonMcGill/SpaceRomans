extends CharacterBody2D

class_name Item

##Base Item Class
##

@onready var state_machine: ItemStateMachine = $ItemStateMachine
@export var item_health : int = 100

var is_obj : bool = false
var is_button : bool = false
var is_dead : bool = false #idk that this makes any sense
signal destroy_objective
signal activate_button

func _process(delta: float) -> void:
	if item_health <= 0:
		if is_obj:
			destroy_objective.emit()
		queue_free()
	if item_health < 100000000000:
		if is_button:
			activate_button.emit()
			item_health = 100000000000

func _create_obj() ->void:
	is_obj = true
	
func _create_button() ->void:
	is_button = true
	item_health = 100000000000

func _ready() -> void:
	state_machine.set_my_item_body(self)
	#if objective.objective == destroy && not item.is_obj == true exists, is_obj = true 
	

