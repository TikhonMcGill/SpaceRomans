extends Node

const BASE_ENEMY_SPEED : int = 200
const BASE_ENEMY_PATROL_SPEED : int = 100

var player_skin_color : Color = CharacterGraphic.HUMAN_SKIN_COLORS.pick_random() #The Color of the Player's skin in Customization
var player_clothing_color : Color = Color.WEB_GRAY #The Color of the Player's clothes
var player_hat : CharacterHat = null #The Hat the Player is wearing

var background_noise : int = 0 #Background Noise, 0 by default - if Player Noise > Background Noise, Enemies will hear
var player_noise : int = 0 #Player Noise, 0 by default - increased by Sprinting & Moving, decreased by standing still and sneaking

var score : int = 0 #Score

var missions : Array[Mission] = []

var mission : Mission = null

var effective_enemy_speed : int = BASE_ENEMY_SPEED
var effective_enemy_patrol_speed : int = BASE_ENEMY_PATROL_SPEED

func _ready() -> void:
	_load_score()

func _load_score():
	if FileAccess.file_exists("user://score.dat") == false:
		score = 0
		save_score()
	else:
		var f = FileAccess.open_encrypted_with_pass("user://score.dat",FileAccess.READ,"legion")
		score = f.get_64()

func save_score():
	var f = FileAccess.open_encrypted_with_pass("user://score.dat",FileAccess.WRITE,"legion")
	f.store_64(score)
	f.close()

func is_player_audible() -> bool:
	return player_noise > background_noise
