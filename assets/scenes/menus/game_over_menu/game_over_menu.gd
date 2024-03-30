extends Control

const MAIN_MENU_PATH := "res://assets/scenes/menus/main_menu/main_menu.tscn"

const TRASH_TALKS := [
	"You wouldn't dare oppose us again... would you?",
	"Ha-ha! Take that, rebel scum!",
	"The Emperor will surely be pleased...",
	"You will NEVER cause us anymore problems!",
	"You were the last - NOBODY will stop us now, NOBODY!",
	"You played, and you lost, because US ROMANS ALWAYS WIN!",
	"Veni, vidi, vici, rebel scum!"
]

@onready var trash_talk_label: Label = $PanelContainer/MarginContainer/VBoxContainer/TrashTalkLabel

func _ready() -> void:
	trash_talk_label.text = TRASH_TALKS.pick_random()

func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_PATH)
