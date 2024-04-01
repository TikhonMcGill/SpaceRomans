extends Node

var player_skin_color : Color = CharacterGraphic.HUMAN_SKIN_COLORS.pick_random() #The Color of the Player's skin in Customization
var player_clothing_color : Color = Color.WEB_GRAY #The Color of the Player's clothes
var player_hat : CharacterHat = null #The Hat the Player is wearing

var background_noise : int = 0 #Background Noise, 0 by default - if Player Noise > Background Noise, Enemies will hear
var player_noise : int = 0 #Player Noise, 0 by default - increased by Sprinting & Moving, decreased by standing still and sneaking

var score : int = 0 #Score

func is_player_audible() -> bool:
	return player_noise > background_noise
