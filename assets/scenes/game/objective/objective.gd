extends Node

class_name Objective


##Base Class for Randomly-Selected Game Objectives

signal objective_complete ##Emitted when the Objective is Complete

var potent_obj = ["break","upload"]
var objective = potent_obj.pick_random()

##A Base Method for checking if the Objective is complete (false by default)
func _is_objective_complete() -> bool:
	#if objective == "break":
		#if is_connected("destroy_objective") #bruh?
		#	return true
	#elif objective == "upload":  #elif
		#if is_connected("activate_button")
	#		return false
	
	return false


##A Base Method for testing if the Objective is complete, and, if it is, emitting the signal
func check_objective_completion() -> void:
	if _is_objective_complete() == true:
		objective_complete.emit()
		
func _ready() -> void:
	if objective == "break":
		var obj_item = Item.new()
		obj_item.is_obj = true
	elif objective == "upload":
		var obj_item = Item.new()
		obj_item.is_button = true
	
