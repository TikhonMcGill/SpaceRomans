extends Node

class_name Objective

##Base Class for Randomly-Selected Game Objectives

signal objective_complete ##Emitted when the Objective is Complete

##A Base Method for checking if the Objective is complete (false by default)
func _is_objective_complete() -> bool:
	return false

##A Base Method for testing if the Objective is complete, and, if it is, emitting the signal
func check_objective_completion() -> void:
	if _is_objective_complete() == true:
		objective_complete.emit()
