extends CharacterBody2D

class_name Enemy

##Base Enemy Class
##
##Enemies have a Cone of Vision, and if they see the player in it, they'll attack

@onready var state_machine: EnemyStateMachine = $EnemyStateMachine

var last_player_position : Vector2 = -Vector2.ONE ##The last position the player was, according to the enemy

func _ready() -> void:
	state_machine.set_my_enemy_body(self)
	state_machine.searching_state.enemy_vision = $EnemyVision

func _on_enemy_hearing_noise_heard(hearing_position: Vector2) -> void:
	state_machine.to_searching_state(hearing_position)
