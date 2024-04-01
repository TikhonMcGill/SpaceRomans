extends Node

class_name Objective

##Base Class for Randomly-Selected Game Objectives

signal objective_complete ##Emitted when the Objective is Complete

const POTENTIAL_OBJECTIVES = ["break","upload","kill"]
const ITEM = preload("res://assets/scenes/game/item/item.tscn")

@export var enemy_to_kill : Enemy
@export var objective : String = POTENTIAL_OBJECTIVES.pick_random()

func set_objective(objective) -> void:
	if objective == "break":
		var obj_item = ITEM.instantiate()
		add_child(obj_item)
		obj_item.is_obj = true
		obj_item.destroy_objective.connect(comp_objective)
	elif objective == "upload":
		var obj_item = ITEM.instantiate()
		add_child(obj_item)
		obj_item.is_button = true
		obj_item.activate_button.connect(comp_objective)
	elif objective == "kill":
		enemy_to_kill.enemy_killed.connect(comp_objective)

func comp_objective() -> void:
	objective_complete.emit()

func _ready() -> void:
	set_objective(objective)

