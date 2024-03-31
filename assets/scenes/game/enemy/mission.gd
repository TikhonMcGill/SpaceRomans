extends Resource

class_name Mission

var mission_ship_name : String
var mission_planet_name : String

func _init() -> void:
	mission_ship_name = NamingManager.generate_ship_name()
	mission_planet_name = NamingManager.generate_planet_name()
