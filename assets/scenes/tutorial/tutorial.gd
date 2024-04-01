extends Node2D

const MAIN_MENU_PATH := "res://assets/scenes/menus/main_menu/main_menu.tscn"

@onready var message_label = $Player/MessageLabel
@onready var player: Player = $Player

var count : int = 0 ##Message Display Number	

var prologue_over : bool = false

@onready var game_tilemap: TileMap = $GameTilemap

# Called when the node enters the scene tree for the first time.
func _ready():
	player.can_move = false
	
	message_label.update_message("The Romans will pay for what they've done...")
	
	await get_tree().create_timer(3).timeout
	
	message_label.update_message("I must get to Space...")
	
	await get_tree().create_timer(2.5).timeout
	
	message_label.update_message("Welcome to the Prologue/Tutorial! You'll be taught some basics here!")
	
	await get_tree().create_timer(3).timeout
	
	message_label.update_message("Press D or Right Arrow to Move Right!")
	player.can_move = true
	prologue_over = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().change_scene_to_file(MAIN_MENU_PATH)
	
	if prologue_over == false:
		return
	
	teach_movement_keys()
	teach_advanced_concepts()

func teach_movement_keys() -> void:
	if Input.is_action_pressed("move_right") == true and count == 0:
		message_label.update_message("Press A or Left Arrow to Move Left!")
		count += 1
	elif Input.is_action_pressed("move_left") == true and count == 1:
		message_label.update_message("Press W or Up Arrow to Move Up!")
		count += 1
	elif Input.is_action_pressed("move_up") == true and count == 2:
		message_label.update_message("Press S or Down Arrow to Move Down!")
		count += 1
	elif Input.is_action_pressed("move_down") == true and count == 3:
		message_label.update_message("Press Shift and any Move Key to Sprint!")
		count += 1

func teach_advanced_concepts() -> void:
	if Input.is_action_pressed("sprint") == true and count == 4:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
			count += 1
			
			player.can_move = false
			
			message_label.update_message("Notice how, when you move, there's a white circle.")
			await get_tree().create_timer(4).timeout
			message_label.update_message("This is your noise radius - the bigger it is, the more likely it is enemies will hear you!")
			await get_tree().create_timer(5).timeout
			message_label.update_message("You make no noise when you're not moving, or when you're sneaking.")
			await get_tree().create_timer(4).timeout
			message_label.update_message("Press Ctrl and any Move Key to Sneak!")
			player.can_move = true
	elif Input.is_action_pressed("sneak") == true and count == 5:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
			count += 1
			player.can_move = false
			
			message_label.update_message("Good!")
			await get_tree().create_timer(1.5).timeout
			message_label.update_message("Enemies can also SEE you - see the red cone of that guard? That's his Vision Cone.")
			await get_tree().create_timer(4.5).timeout
			message_label.update_message("There are two ways to take out an enemy.")
			await get_tree().create_timer(3).timeout
			message_label.update_message("The first way is to shoot them to death using Left Click.")
			await get_tree().create_timer(4).timeout
			message_label.update_message("This is very noisy, and also quite slow.")
			await get_tree().create_timer(4).timeout
			message_label.update_message("The second way is sneak up behind the Enemy's Vision cone and snap his neck using the F key.")
			await get_tree().create_timer(7).timeout
			message_label.update_message("This is instant and noise-free.")
			await get_tree().create_timer(3).timeout
			
			message_label.update_message("Oh, looks like there was a malfunction and your cell has been compromised.")
			var cell_to_remove = game_tilemap.get_used_cells_by_id(0,14).pick_random()
			game_tilemap.set_cell(0,cell_to_remove,0,Vector2i.ZERO)
			await get_tree().create_timer(5).timeout
			
			message_label.update_message("Kill the Guard, and the tutorial will be complete!")
			player.can_move = true

func _on_tutorial_objective_objective_complete() -> void:
	message_label.update_message("The guard is dead. Time to go to space and show these Romans who's boss...")
	await get_tree().create_timer(5).timeout
	message_label.update_message("Congratulations! You can now start playing!")
	await get_tree().create_timer(4).timeout
	
	get_tree().change_scene_to_file(MAIN_MENU_PATH)
