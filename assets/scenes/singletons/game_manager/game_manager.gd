extends Node

const BASE_ENEMY_SPEED : int = 200
const BASE_ENEMY_PATROL_SPEED : int = 100
const BASE_ENEMY_DAMAGE : int = 50 ##Test TODO
const BASE_ENEMY_HEALTH : int = 100 ##Test TODO

const BASE_PLAYER_DAMAGE : int = 10 ##Test TODO
const BASE_PLAYER_WALK_NOISE : int = 32 ## Test TODO
const BASE_PLAYER_SPRINT_NOISE : int = 64 ## Test TODO
const BASE_PLAYER_SNEAK_SPEED : int = 75 ## Test TODO
const BASE_PLAYER_SHOOT_RANGE : int = 128 ## Test TODO
const BASE_PLAYER_HEALTH : int = 100 ## Test TODO

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
var effective_enemy_damage : int = BASE_ENEMY_DAMAGE ##Test TODO
var effective_enemy_health : int = BASE_ENEMY_HEALTH ##Test TODO

var effective_player_damage : int = BASE_PLAYER_DAMAGE ##Test TODO
var effective_player_walk_noise : int = BASE_PLAYER_WALK_NOISE ##Test TODO
var effective_player_sprint_noise : int = BASE_PLAYER_SPRINT_NOISE ##Test TODO
var effective_player_sneak_speed : int = BASE_PLAYER_SNEAK_SPEED ##Test TODO
var effective_player_shoot_range : int = BASE_PLAYER_SHOOT_RANGE ##Test TODO
var effective_player_health : int = BASE_PLAYER_HEALTH

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

##Test function for gameplay modifier (Rage) ##TODO 
func _set_enemy_damage(enemy_damage_value: int):
	effective_enemy_damage = enemy_damage_value
	
##Test function for gameplay modifier (Juggernaut) ##TODO 
func _set_enemy_health(enemy_health_value: int):
	effective_enemy_health = enemy_health_value

##Test function for gameplay modifier (Taxed) ##TODO 
func _set_enemy_movement_and_patrol_speed(enemy_movement_speed_value: int, enemy_patrol_speed_value: int):
	effective_enemy_speed = enemy_movement_speed_value
	effective_enemy_patrol_speed = enemy_patrol_speed_value

##Test function for gameplay modifier (Olive Branch) ##TODO 
func _set_player_damage(player_damage_value: int):
	effective_player_damage = player_damage_value

##Test function for gameplay modifier (Assassin) ##TODO
func _set_player_sneak_speed(player_sneak_speed_value: int):
	effective_player_sneak_speed = player_sneak_speed_value
	
##Test function for gameplay modifier (Sharpshooter) ##TODO
func _set_player_shoot_range(player_shoot_range_value: int):
	effective_player_shoot_range = player_shoot_range_value

##Test function for gameplay modifier (Gladiator) ##TODO 
func _set_player_health(player_health_value: int):
	effective_player_health = player_health_value

##Test function for gameplay modifier (Phantom) 
func _set_player_walk_and_sprint_noise(player_walk_noise_value: int, player_sprint_noise_value: int):
	effective_player_walk_noise = player_walk_noise_value
	effective_player_sprint_noise = player_sprint_noise_value
