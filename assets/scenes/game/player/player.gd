extends CharacterBody2D #The Player Class inherits all methods and variables from CharacterBody2D

class_name Player #Using "class_name" means other scripts will be able to see this class and provide hints

const GAME_OVER_PATH := "res://assets/scenes/menus/game_over_menu/game_over_menu.tscn"

#CTRL + Click on most Green Class Names, and Godot will automatically open the Documentation on that Class for you
#You can see the Double hashes ("##") have different colors - those are Autodocumentation FOR OUR OWN CLASSES, which means
#if you CTRL + Click on "Player" in a different script, you'll be shown documentation on it!

##The Main Player Class
##
##The User controls the player, moving around using WASD, Sprinting using Shift, Sneaking using CTRL

signal game_over ##Emitted when the Player's health reaches 0 (or when they fail the objective, but that's TODO)

#@export means that the Variable can be edited in the inspector

@export var base_speed : int = 200 ##The Base Speed of the Player, when they're not Sprinting or sneaking
@export var sprint_speed : int = 400 ##The Speed of the Player when they're sprinting using SHIFT

##@export var sneak_speed : int = 75 ##The Speed of the Player when they're sneaking using CTRL (Original version)
@export var sneak_speed : int = GameManager.effective_player_sneak_speed ##The Speed of the Player when they're sneaking using CTRL (Test modified version) TODO

##@export var shoot_range : int = 128 ##The Maximum Range the Player can shoot (Original version)
@export var shoot_range : int = GameManager.effective_player_shoot_range ##The Maximum Range the Player can shoot (Test modified version) TODO


##@export var shoot_damage : int = 10 ##The Damage the Player does when Shooting (Original version)
@export var shoot_damage : int = GameManager.effective_player_damage ##The Damage the Player does when Shooting (Test modified version) TODO

##@export var walk_noise : int = 32 ##The Base Noise when the Player is walking (Original version) 
@export var walk_noise : int = GameManager.effective_player_walk_noise ##The Base Noise when the Player is walking (Test modified version) TODO

##@export var sprint_noise : int = 64 ##The Noise when the Player is sprinting (Original version) 
@export var sprint_noise : int = GameManager.effective_player_sprint_noise ##The Noise when the Player is sprinting (Test modified version) TODO
@export var shoot_noise : int = 128 ##The Noise when the Player is shooting

@onready var player_character_graphic: CharacterGraphic = $PlayerCharacterGraphic

@onready var player_noise: NoiseMaker = $PlayerNoise

@onready var player_snapping: Area2D = $PlayerSnapping

@onready var shoot_cast: RayCast2D = $ShootCast

@onready var laserbeam: Line2D = $Laserbeam

var shooting : bool = false ##Whether or not the player is shooting - useful for a (ugly) solution to noise radius being overwritten when shooting

##var player_health : int = 100 ##The Health of the Player (Original version)
var player_health : int = GameManager.effective_player_health ##The Health of the Player (Test modified version)

var can_move : bool = true ##Whether or not the player can move (for tutorial)

func _ready() -> void:
	player_character_graphic.my_character = self
	player_character_graphic.set_skin_color(GameManager.player_skin_color)
	player_character_graphic.set_clothing_color(GameManager.player_clothing_color)
	player_character_graphic.set_hat(GameManager.player_hat)

func _process(delta: float) -> void:
	if player_health <= 0:
		GameManager.score -= 100
		GameManager.save_score()
		get_tree().change_scene_to_file(GAME_OVER_PATH)
	
	_handle_combat()
	queue_redraw()

#Physics Process is run every Physics frame,
#so it's good to do movement etc. in it (to prevent Bethesda-like Physics being dependent on Framerate)
func _physics_process(delta: float) -> void:
	_handle_movement()
	_handle_noise()
	move_and_slide() #Move and Slide is a built in method of CharacterBody2D, and is good because characters gracefully slide against e.g. slopes, instead of just getting stopped

##A Function to handle player Combat
func _handle_combat() -> void:
	if Input.is_action_just_pressed("neck_snap") == true:
		_handle_neck_snap()
	elif Input.is_action_just_pressed("shoot") == true:
		_handle_shooting()

##A Function to Handle the Player stealthily killing an enemy using a Neck Snap
func _handle_neck_snap() -> void:
	var possible_enemies := player_snapping.get_overlapping_bodies()
	if len(possible_enemies) > 0:
		var enemy : Enemy = possible_enemies[0]
		
		if enemy.state_machine.current_state != enemy.state_machine.combat_state:
			GameManager.score += 10
			GameManager.save_score()
			enemy.enemy_health = 0

##A Function to Handle the Player Shooting using Left Click
func _handle_shooting() -> void:
	shoot_cast.target_position = get_global_mouse_position() - shoot_cast.global_position
	shoot_cast.target_position = shoot_cast.target_position.limit_length(shoot_range)
	
	var starting_noise_radius := player_noise.noise_radius
	var starting_player_noise := GameManager.player_noise
	
	var tween := get_tree().create_tween()
	var tween_2 := get_tree().create_tween()
	var tween_3 := get_tree().create_tween()
	
	shooting = true
	
	
	tween.tween_property(player_noise,"noise_radius",shoot_noise,0.1)
	tween.tween_property(player_noise,"noise_radius",starting_noise_radius,0.1)
	
	tween_2.tween_property(GameManager,"player_noise",10,0.1)
	tween_2.tween_property(GameManager,"player_noise",starting_player_noise,0.1)
	
	shoot_cast.force_raycast_update()
	
	laserbeam.points[0] = Vector2.ZERO
	
	var victim := shoot_cast.get_collider()
	
	if victim != null:
		laserbeam.points[1] = shoot_cast.get_collision_point() - global_position
	else:
		laserbeam.points[1] = shoot_cast.target_position
	
	laserbeam.visible = true
	
	tween_3.tween_property(laserbeam,"modulate:a",1,0.1)
	tween_3.tween_property(laserbeam,"modulate:a",0,0.1)
	
	if victim != null:
		if victim is Enemy:
			victim.enemy_health -= shoot_damage
			if victim.enemy_health <= 0:
				GameManager.score += 5
				GameManager.save_score()
			victim.state_machine.combat_state.target = self
			victim.state_machine.to_combat_state()
		elif victim is Item:
			victim.item_health -= shoot_damage
	
	await tween.finished
	
	shooting = false
	laserbeam.visible = false
	
#In Godot, starting a function with an underline is mostly a convenient way of establishing
#private methods - methods starting with an underline aren't shown in external classes (unless explicitly searched for)
#which is useful to prevent clutter

##A Function to Handle Player Movement - movement using WASD/Arrow Keys, Sprinting with SHIFT, Sneaking with CTRL
func _handle_movement() -> void:
	if can_move == false:
		return
	
	# ":=" is Syntactic Sugar for Inferring a Type based on the variable set, 
	#e.g. I could've written "var input_vector : Vector2 = Vector2.ZERO", but it's simpler
	#to write what I did below
	
	var input_vector := Vector2.ZERO #Initialize a 0-Vector, because there's no Input
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	#Normalize the Input vector (so that moving diagonally isn't faster due to Pythagoras' Theorem)
	velocity = input_vector.normalized() * _get_effective_speed()

#In Godot "->" and then a Type specifies the return type of a function - this helps optimize compilation and
#provides typehints, but is also optional.

#Godot can automatically type things for you, and I recommend it for better hints & autocompletion. 
#To activate autocompletion, in the Top Bar of the Editor press:
# Editor -> Editor Settings -> Search "completion" -> Select "Completion" -> Tick "Add Type Hints"

##A Function to Get the Effective Speed of the Player, dependent on if they're Sprinting or Sneaking
func _get_effective_speed() -> int:
	#== true is optional, I'm just in the habit of doing it for readability
	if Input.is_action_pressed("sprint") == true:
		GameManager.player_noise = 2
		return sprint_speed
	elif Input.is_action_pressed("sneak") == true:
		GameManager.player_noise = 0
		return sneak_speed
	
	GameManager.player_noise = 1
	return base_speed

##A Function to handle the Player's Noise dependent on if they're moving or not
func _handle_noise() -> void:
	if shooting == true:
		return
	
	#If the Player is not moving (i.e. velocity is 0), Player Noise is 0
	if velocity.length() == 0 and shooting == false:
		GameManager.player_noise = 0
		player_noise.noise_radius = 0
	#If the Player's speed is Sneak Speed (i.e. they're sneaking), Player Noise is 0
	elif velocity.length() == sneak_speed and shooting == false:
		GameManager.player_noise = 0
		player_noise.noise_radius = 0
	#If the Player's speed is Sprint Speed (i.e. they're sprinting), Player Noise is 2
	elif velocity.length() == sprint_speed and (shooting == false or player_noise.noise_radius < sprint_noise):
		GameManager.player_noise = 2
		player_noise.noise_radius = sprint_noise
	#Otherwise, Player noise is 1
	else:
		if (shooting == false or player_noise.noise_radius < walk_noise):
			player_noise.noise_radius = walk_noise
			GameManager.player_noise = 1

func _draw() -> void:
	#If the Player noise is greater than 0, draw a circle with the radius equalling the noise
	if player_noise.noise_radius > 0:
		var noise_color = Color.WHITE
		noise_color.a = 0.5
		draw_circle(Vector2.ZERO,player_noise.noise_radius,noise_color)
