extends CharacterBody2D

class_name Enemy

##Base Enemy Class
##
##Enemies have a Cone of Vision, and if they see the player in it, they'll attack

@export var enemy_speed : int = 200
##@export var enemy_damage : int = 50 ##Test - commented out
@export var enemy_health : int = 100

##Test variable for Anger gameplay modifier
static var enemy_damage : int = 50

@export var patrol_points : Array[PatrolPoint] = []
@export var back_and_forth_patrol : bool = false

@onready var state_machine: EnemyStateMachine = $EnemyStateMachine

@onready var enemy_vision: PlayerSeer = $EnemyVision

var last_player_position : Vector2 = -Vector2.ONE ##The last position the player was, according to the enemy

func _process(delta: float) -> void:
	if enemy_health <= 0:
		queue_free()

func _ready() -> void:
	state_machine.set_my_enemy_body(self)
	
	state_machine.searching_state.enemy_vision = $EnemyVision
	
	state_machine.patrolling_state.patrol_points = patrol_points
	state_machine.patrolling_state.back_and_forth = back_and_forth_patrol

func _physics_process(delta: float) -> void:
	if velocity.length_squared() > 0.05:
		enemy_vision.rotation = lerp_angle(enemy_vision.rotation,velocity.angle(),0.04)

func look_at_point(pos : Vector2) -> void:
	enemy_vision.rotation = lerp_angle(enemy_vision.rotation,enemy_vision.global_position.angle_to_point(pos),0.1)

##Test static function for gameplay modifier (Anger)
static func _set_enemy_damage(enemy_damage_value: int):
	enemy_damage = enemy_damage_value
