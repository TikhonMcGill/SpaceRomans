extends Resource

class_name Mission

var mission_ship_name : String
var mission_planet_name : String

var mission_objective : String

func _init(_name:String,_planet:String,_objective:String) -> void:
	mission_ship_name = _name
	mission_planet_name = _planet
	mission_objective = _objective
