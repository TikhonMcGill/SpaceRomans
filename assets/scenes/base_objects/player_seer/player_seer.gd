extends Node2D

class_name PlayerSeer

##A Class that detects the player using a Cone of Vision and Raycast

signal player_seen(player : Player) ##Emitted when the Player is visible in the cone of vision
signal player_unseen(last_position : Vector2) ##Emitted when the Player is no longer visible

@onready var field_of_view: Area2D = $FieldOfView
@onready var player_cast: RayCast2D = $PlayerCast

var player_in_cone : Player = null ##The Player (if any) the Player Seer sees in the cone of vision
var player_detected : bool = false ##Whether or not the player has been detected

func can_see_player() -> bool:
	return player_in_cone != null

func _process(delta: float) -> void:
	#If there is a player visible, we handle the Raycast pointing at the player
	if player_in_cone:
		if field_of_view.get_overlapping_bodies().has(player_in_cone) == false:
			player_in_cone = null
			player_cast.enabled = false
			return
		
		player_cast.enabled = true
		player_cast.global_rotation = player_cast.global_position.angle_to_point(player_in_cone.global_position)
		player_cast.force_raycast_update()
		
		var is_detected = player_cast.is_colliding()
		
		if is_detected == true:
			player_seen.emit(player_in_cone)
			player_detected = true
		elif is_detected == false and player_detected == true:
			#If the player is no longer visible, transmit their last
			#position
			player_unseen.emit(player_in_cone.global_position)
			player_detected = false

#When a Body enters, it can only be the player, so we make that the player in cone
func _on_field_of_view_body_entered(body: Node2D) -> void:
	player_in_cone = body

#When a Body exits, it can only be the player (and this is a singleplayer game)
#so we set "player_in_cone" to null
func _on_field_of_view_body_exited(body: Node2D) -> void:
	player_in_cone = null
