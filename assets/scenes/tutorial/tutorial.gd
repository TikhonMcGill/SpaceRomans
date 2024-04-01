extends Node2D

@onready var message_label = $Player/MessageLabel
@onready var player: Player = $Player

var count : int = 0 ##Message Display Number	

var prologue_over : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player.can_move = false
	
	message_label.update_message("The Romans will pay for what they've done...")
	
	await get_tree().create_timer(2).timeout
	
	message_label.update_message("I must get to Space...")
	
	await get_tree().create_timer(1.5).timeout
	
	message_label.update_message("Welcome to the Prologue/Tutorial! You'll be taught some basics here!")
	
	await get_tree().create_timer(2).timeout
	
	message_label.update_message("Press D or Right Arrow to Move Right!")
	player.can_move = true
	prologue_over = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if prologue_over == true:
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
		elif Input.is_action_pressed("sprint") == true and count == 4:
			message_label.update_message("Press Ctrl and any Move Key to Sneak!")
			count += 1
		elif Input.is_action_pressed("sneak") == true and count == 5:
			message_label.update_message("Congratulations! You can now start you game.")
			count += 1
		elif count == 6:
			message_label.hide_message()
			count += 1
