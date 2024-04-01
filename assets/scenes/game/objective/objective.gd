extends Node

class_name Objective

##Base Class for Randomly-Selected Game Objectives

signal objective_complete ##Emitted when the Objective is Complete

const POTENTIAL_OBJECTIVES = ["break","upload","kill"]
const ITEM = preload("res://assets/scenes/game/item/item.tscn")

@export var enemy_to_kill : Enemy

func set_objective(objective : String,position : Vector2) -> void:
	if objective == "break":
		var obj_item = ITEM.instantiate()
		obj_item.global_position = position
		add_child(obj_item)
		obj_item._create_obj()
		obj_item.destroy_objective.connect(comp_objective)
	elif objective == "upload":
		var obj_item = ITEM.instantiate()
		add_child(obj_item)
		obj_item.global_position = position
		obj_item._create_button()
		obj_item.activate_button.connect(comp_objective)
	elif objective == "kill":
		enemy_to_kill.enemy_killed.connect(comp_objective)

func comp_objective() -> void:
	GameManager.score += 100
	GameManager.save_score()
	objective_complete.emit()
