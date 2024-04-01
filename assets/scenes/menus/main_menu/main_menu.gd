extends Control

const TUTORIAL_PATH := "res://assets/scenes/tutorial/tutorial.tscn"
const MISSION_SELECT_PATH := "res://assets/scenes/menus/mission_select_menu/mission_select_menu.tscn"

@onready var main_menu_container: VBoxContainer = $PanelContainer/MarginContainer/MainMenuContainer
@onready var character_customization_container: ScrollContainer = $PanelContainer/MarginContainer/CharacterCustomizationContainer

@onready var score_label: Label = $PanelContainer/MarginContainer/MainMenuContainer/ScoreLabel

func _ready() -> void:
	main_menu_container.visible = true
	character_customization_container.visible = false

func _on_quit_game_button_pressed() -> void:
	get_tree().quit()

func _on_customize_character_button_pressed() -> void:
	main_menu_container.visible = false
	character_customization_container.visible = true

func _on_customization_back_button_pressed() -> void:
	character_customization_container.visible = false
	main_menu_container.visible = true

func _on_prologue_button_pressed() -> void:
	get_tree().change_scene_to_file(TUTORIAL_PATH)

func _on_mission_select_button_pressed() -> void:
	get_tree().change_scene_to_file(MISSION_SELECT_PATH)

func _process(delta: float) -> void:
	score_label.text = "Your Score: %d" % GameManager.score
