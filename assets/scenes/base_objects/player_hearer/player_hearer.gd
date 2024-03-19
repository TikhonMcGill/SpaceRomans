extends Area2D

class_name PlayerHearer

##A Class that handles hearing Player Noise
##
##The Hearer will detect the player if they make noise > background noise in their radius of Sensitivity

signal noise_heard(hearing_position : Vector2) ##Emitted when the player is "heard" (player is in the hearing range, and player noise > background noise)

@export var sensitivity : int = 10 ##How "sensitive" the Hearer is to noise (conceptually, just the radius of the detection circle)

@onready var hearing_radius : CircleShape2D = $CollisionShape2D.shape

func _ready() -> void:
	#Update the Collision Circle's radius to the sensitivity
	hearing_radius.radius = sensitivity

#Since there might be issues with detecting noise just as it happens, we'll instead check
#for it every 0.1 seconds
func _on_hear_timer_timeout() -> void:
	var noise_makers := get_overlapping_areas()
	if len(noise_makers) > 0 and GameManager.is_player_audible() == true:
		#Just in case there's more than one source of noise, pick randomly among them
		noise_heard.emit(noise_makers.pick_random().global_position)
