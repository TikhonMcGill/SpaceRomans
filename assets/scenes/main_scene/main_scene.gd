extends Node2D

const MISSION_SELECT_PATH := "res://assets/scenes/menus/mission_select_menu/mission_select_menu.tscn"

const ENEMY_SCENE := preload("res://assets/scenes/game/enemy/enemy.tscn")

@onready var enemies: Node2D = $Enemies
@onready var possible_objective_positions: Node2D = $PossibleObjectivePositions

@onready var mission_objective: Objective = $MissionObjective

@onready var complete_label: Label = $Player/CompleteLabel

@onready var player: Player = $Player

func _ready() -> void:
	randomize_enemy_layout()
	initialize_objective()
	initialize_modifier()

func initialize_modifier():
	var modifier : Modifier = GameManager.mission.mission_modifier
	ModifierManager._activate_gameplay_modifier(modifier)
	player.apply_values()
	
	for e : Enemy in enemies.get_children():
		e.apply_values()
	
func initialize_objective():
	var objective_positions : Array[Node] = possible_objective_positions.get_children()
	
	var objective_position : Vector2 = objective_positions.pick_random().global_position
	
	if GameManager.mission.mission_objective == "kill":
		var new_legate : Enemy = ENEMY_SCENE.instantiate()
		enemies.add_child(new_legate)
		new_legate.enemy_character_graphic.set_clothing_color(Color.GOLD)
		
		new_legate.global_position = objective_position
		
		mission_objective.enemy_to_kill = new_legate
	
	mission_objective.set_objective(GameManager.mission.mission_objective,objective_position)
	
func randomize_enemy_layout():
	var max_enemies := enemies.get_child_count()
	
	var enemies_to_keep = randi_range(1,max_enemies)
	
	var enemies_to_delete = max_enemies - enemies_to_keep
	
	for x in range(enemies_to_delete):
		var victim : Enemy = enemies.get_children().pick_random()
		victim.queue_free()

func _on_mission_objective_objective_complete() -> void:
	for e : Enemy in enemies.get_children():
		e.enemy_health = -1000
	complete_label.visible = true
	
	await get_tree().create_timer(5).timeout
	
	get_tree().change_scene_to_file(MISSION_SELECT_PATH)
