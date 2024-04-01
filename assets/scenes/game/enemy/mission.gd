extends Resource

class_name Mission

var mission_ship_name : String
var mission_planet_name : String

var mission_objective : String

var mission_modifier : Modifier

func _init(_name:String,_planet:String,_objective:String,_modifier:Modifier) -> void:
	mission_ship_name = _name
	mission_planet_name = _planet
	mission_objective = _objective
	mission_modifier = _modifier
