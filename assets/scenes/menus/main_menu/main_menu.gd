extends Control

const TUTORIAL_PATH := "res://assets/scenes/tutorial/tutorial.tscn"

@onready var main_menu_container: VBoxContainer = $PanelContainer/MarginContainer/MainMenuContainer
@onready var character_customization_container: ScrollContainer = $PanelContainer/MarginContainer/CharacterCustomizationContainer

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
