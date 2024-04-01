extends Control

const MAIN_MENU_PATH := "res://assets/scenes/menus/main_menu/main_menu.tscn"

func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_PATH)
