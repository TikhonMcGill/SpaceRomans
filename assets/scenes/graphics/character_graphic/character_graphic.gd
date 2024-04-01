extends Node2D

class_name CharacterGraphic

const BODY_FRONT = preload("res://assets/scenes/graphics/character_graphic/bodies/body_front.png")
const BODY_SIDE = preload("res://assets/scenes/graphics/character_graphic/bodies/body_side.png")
const BODY_BACK = preload("res://assets/scenes/graphics/character_graphic/bodies/body_back.png")

const HEAD_FRONT = preload("res://assets/scenes/graphics/character_graphic/heads/head_front.png")
const HEAD_SIDE = preload("res://assets/scenes/graphics/character_graphic/heads/head_side.png")
const HEAD_BACK = preload("res://assets/scenes/graphics/character_graphic/heads/head_back.png")

const HUMAN_SKIN_COLORS : Array[Color] = [
	Color.TAN,
	Color.SADDLE_BROWN,
	Color.DARK_SALMON,
	Color.LIGHT_SALMON,
	Color.BEIGE
]

@export var hat : CharacterHat = null

@onready var character_body: Sprite2D = $CharacterBody
@onready var character_head: Sprite2D = $CharacterHead
@onready var character_hat: Sprite2D = $CharacterHat

var test_rotation := 0

var my_character : CharacterBody2D

func _process(delta: float) -> void:
	if hat == null:
		character_hat.visible = false
	
	if my_character == null:
		return
	
	var velocity := my_character.velocity
	
	if my_character is Player:
		if int(velocity.length()) == 0:
			return
		
		if velocity.x > 0:
			update_rotation(90)
		elif velocity.x < 0:
			update_rotation(270)
		elif velocity.y > 0:
			update_rotation(180)
		else:
			update_rotation(0)
	elif my_character is Enemy:
		update_rotation(
			my_character.enemy_vision.rotation_degrees + 90
		)

func set_clothing_color(color : Color) -> void:
	character_body.modulate = color

func set_skin_color(color : Color) -> void:
	character_head.modulate = color

func get_random_human_skin_color() -> Color:
	return HUMAN_SKIN_COLORS.pick_random()

func set_hat(new_hat : CharacterHat) -> void:
	hat = new_hat
	character_hat.visible = true

func look_up() -> void:
	character_body.texture = BODY_BACK
	character_head.texture = HEAD_BACK
	
	if hat != null:
		character_hat.texture = hat.hat_back

func look_down() -> void:
	character_body.texture = BODY_FRONT
	character_head.texture = HEAD_FRONT
	
	if hat != null:
		character_hat.texture = hat.hat_front

func look_right() -> void:
	character_body.texture = BODY_SIDE
	character_body.scale.x = 1
	character_head.texture = HEAD_SIDE
	character_head.scale.x = 1
	
	if hat != null:
		character_hat.texture = hat.hat_side
		character_hat.scale.x = 1

func look_left() -> void:
	character_body.texture = BODY_SIDE
	character_body.scale.x = -1
	character_head.texture = HEAD_SIDE
	character_head.scale.x = -1
	
	if hat != null:
		character_hat.texture = hat.hat_side
		character_hat.scale.x = -1

func update_rotation(rotation_in_degrees : float) -> void:
	rotation_in_degrees = wrapf(rotation_in_degrees,0,360)
	
	if rotation_in_degrees > 225:
		look_left()
	elif rotation_in_degrees > 135:
		look_down()
	elif rotation_in_degrees >= 45:
		look_right()
	else:
		look_up()
