extends CharacterBody2D

class_name Item

const STATUE_TEXTURE := preload("res://assets/scenes/game/item/statue.png")
const BUTTON_TEXTURE := preload("res://assets/scenes/game/item/Button.png")

@onready var icon: Sprite2D = $Icon

@onready var explanation_label: Label = $ExplanationLabel

@export var item_health : int = 100

var is_obj : bool = false
var is_button : bool = false
var is_dead : bool = false #idk that this makes any sense
signal destroy_objective
signal activate_button

func _process(delta: float) -> void:
	if is_obj:
		icon.texture = STATUE_TEXTURE
		explanation_label.text = "Destroy this Statue to complete the Mission"
	elif is_button:
		icon.texture = BUTTON_TEXTURE
		explanation_label.text = "Shoot this Button to complete the Mission"
	
	if item_health <= 0:
		if is_obj:
			print("Destroyed!")
			destroy_objective.emit()
		queue_free()
	if is_button and item_health < 100_000_000_000:
		print("Button clicked!")
		activate_button.emit()
		item_health = 100_000_000_000

func _create_obj() ->void:
	is_obj = true

func _create_button() ->void:
	is_button = true
	item_health = 100_000_000_000
