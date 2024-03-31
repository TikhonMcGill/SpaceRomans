extends CharacterBody2D

class_name Enemy

##Base Enemy Class
##
##Enemies have a Cone of Vision, and if they see the player in it, they'll attack

@export var enemy_speed : int = 200
@export var enemy_damage : int = 50
@export var enemy_health : int = 100

@export var patrol_points : Array[PatrolPoint] = []
@export var back_and_forth_patrol : bool = false

@onready var enemy_character_graphic: CharacterGraphic = $EnemyCharacterGraphic

@onready var state_machine: EnemyStateMachine = $EnemyStateMachine

@onready var enemy_vision: PlayerSeer = $EnemyVision

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var last_player_position : Vector2 = -Vector2.ONE ##The last position the player was, according to the enemy

var dead := false

func _die() -> void:
	if dead == true:
		return
	
	dead = true
	velocity = Vector2.ZERO
	state_machine.queue_free()
	enemy_vision.visible = false
	
	collision_shape_2d.disabled = true
	
	var new_tween := create_tween()
	new_tween.tween_property(self,"modulate",Color.BLACK,0.1)
	new_tween.tween_property(self,"rotation_degrees",randi_range(45,270),0.4)
	new_tween.tween_property(self,"modulate:a",0,1.5)
	new_tween.tween_callback(queue_free)

func _process(delta: float) -> void:
	if enemy_health <= 0:
		_die()

func _ready() -> void:
	enemy_character_graphic.my_character = self
	
	var roman_colors := [
		Color.PURPLE,
		Color.WEB_MAROON
	]
	
	enemy_character_graphic.set_clothing_color(roman_colors.pick_random())
	enemy_character_graphic.set_skin_color(enemy_character_graphic.get_random_human_skin_color())
	
	var roman_helmet : CharacterHat = load("res://assets/scenes/graphics/character_graphic/hats/roman_helmet/roman_helmet.tres")
	
	enemy_character_graphic.set_hat(roman_helmet)
	
	state_machine.set_my_enemy_body(self)
	
	state_machine.searching_state.enemy_vision = $EnemyVision
	
	state_machine.patrolling_state.patrol_points = patrol_points
	state_machine.patrolling_state.back_and_forth = back_and_forth_patrol

func _physics_process(delta: float) -> void:
	if velocity.length_squared() > 0.05:
		enemy_vision.rotation = lerp_angle(enemy_vision.rotation,velocity.angle(),0.04)

func look_at_point(pos : Vector2) -> void:
	enemy_vision.rotation = lerp_angle(enemy_vision.rotation,enemy_vision.global_position.angle_to_point(pos),0.1)
