extends Control

const MAIN_MENU_PATH := "res://assets/scenes/menus/main_menu/main_menu.tscn"
const MAIN_GAME_PATH := "res://assets/scenes/main_scene/main_scene.tscn"

@onready var mission_list: ItemList = $PanelContainer/MarginContainer/VBoxContainer/MissionList

@onready var score_label: Label = $PanelContainer/MarginContainer/VBoxContainer/ScoreLabel

@onready var modifier_label: Label = $PanelContainer/MarginContainer/VBoxContainer/ModifierLabel

var existing_ship_names : Array[String] = []

func _ready() -> void:
	ModifierManager._reset_modifiers()
	generate_missions()
	populate_missions()

func generate_missions() -> void:
	if len(GameManager.missions) < 5:
		var difference = 5 - len(GameManager.missions)
		
		for x in range(difference):
			var ship_name = NamingManager.generate_ship_name()
			while existing_ship_names.has(ship_name) == true:
				ship_name = NamingManager.generate_ship_name()
			existing_ship_names.append(ship_name)
			
			var planet_name = NamingManager.generate_planet_name()
			
			var objective = Objective.POTENTIAL_OBJECTIVES.pick_random()
			
			var modifier : Modifier = ModifierManager.gameplay_modifiers.pick_random()
			
			var new_mission := Mission.new(ship_name,planet_name,objective,modifier)
			
			GameManager.missions.append(new_mission)

func populate_missions() -> void:
	for mission : Mission in GameManager.missions:
		mission_list.add_item(
			"Ship: %s, Orbiting %s, Objective: %s" % [
				mission.mission_ship_name,
				mission.mission_planet_name,
				stringify_objective(mission.mission_objective)
			]
		)

func stringify_objective(objective : String) -> String:
	if objective == "break":
		return "Destroy Sacred Statue"
	elif objective == "upload":
		return "Upload Virus to Ship System"
	elif objective == "kill":
		return "Kill Imperial Legate"
	return "No objective"

func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_PATH)

func _on_mission_list_item_activated(index: int) -> void:
	var selected_mission := GameManager.missions[index]
	GameManager.missions.erase(selected_mission)
	GameManager.mission = selected_mission
	get_tree().change_scene_to_file(MAIN_GAME_PATH)

func _process(delta: float) -> void:
	score_label.text = "Your Score: %d" % GameManager.score

func _on_mission_list_item_selected(index: int) -> void:
	var mod : Modifier = GameManager.missions[index].mission_modifier
	modifier_label.text = "Modifier: %s - %s" % [mod.modifier_name,mod.modifier_description]
	modifier_label.visible = true
