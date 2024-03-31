extends Area2D

class_name PlayerHearer

##A Class that handles hearing Player Noise
##
##The Hearer will detect the player if they make noise > background noise in their radius of Sensitivity

signal noise_heard(hearing_position : Vector2) ##Emitted when the player is "heard" (player is in the hearing range, and player noise > background noise)

@export var sensitivity : int = 10 ##How "sensitive" the Hearer is to noise (conceptually, just the radius of the detection circle)

@onready var hearing_radius : CircleShape2D = $CollisionShape2D.shape

@onready var obstacle_cast: RayCast2D = $ObstacleCast

func _ready() -> void:
	#Update the Collision Circle's radius to the sensitivity
	hearing_radius.radius = sensitivity

#Since there might be issues with detecting noise just as it happens, we'll instead check
#for it every 0.1 seconds
func _on_hear_timer_timeout() -> void:
	var noise_makers := get_overlapping_areas()
	if len(noise_makers) > 0 and GameManager.is_player_audible() == true:
		#Just in case there's more than one source of noise, pick randomly among them
		var noise_maker = noise_makers.pick_random()
		
		#This extra code is to make sure the player can't be heard through walls
		obstacle_cast.enabled = true
		obstacle_cast.target_position = noise_maker.global_position - global_position
		obstacle_cast.force_raycast_update()
		
		if obstacle_cast.is_colliding() == true and obstacle_cast.get_collider() is Player:
			noise_heard.emit(noise_maker.global_position)
