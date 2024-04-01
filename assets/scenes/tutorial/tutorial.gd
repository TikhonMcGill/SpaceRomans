extends Node2D

@onready var message_label = $Player/MessageLabel

var count : int = 0 ##Message Display Number	

# Called when the node enters the scene tree for the first time.
func _ready():
	message_label.show_message()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_right") == true and count == 0:
		message_label.update_message("Press Left Button to Move Left!")
		count += 1
	elif Input.is_action_pressed("move_left") == true and count == 1:
		message_label.update_message("Press Up Button to Move Up!")
		count += 1
	elif Input.is_action_pressed("move_up") == true and count == 2:
		message_label.update_message("Press Down Button to Move Down!")
		count += 1
	elif Input.is_action_pressed("move_down") == true and count == 3:
		message_label.update_message("Press Shift and Move Key Button to Sprint!")
		count += 1
	elif Input.is_action_pressed("sprint") == true and count == 4:
		message_label.update_message("Press Ctrl and Move Key Button to Sneak!")
		count += 1
	elif Input.is_action_pressed("sneak") == true and count == 5:
		message_label.update_message("Congratulations! You can now start you game.")
		count += 1
	elif count == 6:
		message_label.hide_message()
		count += 1
