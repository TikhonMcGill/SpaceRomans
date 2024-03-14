extends CharacterBody2D #The Player Class inherits all methods and variables from CharacterBody2D

class_name Player #Using "class_name" means other scripts will be able to see this class and provide hints

#CTRL + Click on most Green Class Names, and Godot will automatically open the Documentation on that Class for you
#You can see the Double hashes ("##") have different colors - those are Autodocumentation FOR OUR OWN CLASSES, which means
#if you CTRL + Click on "Player" in a different script, you'll be shown documentation on it!

##The Main Player Class
##
##The User controls the player, moving around using WASD, Sprinting using Shift, Sneaking using CTRL

#@export means that the Variable can be edited in the inspector

@export var base_speed : int = 200 ##The Base Speed of the Player, when they're not Sprinting or sneaking
@export var sprint_speed : int = 400 ##The Speed of the Player when they're sprinting using SHIFT
@export var sneak_speed : int = 50 ##The Speed of the Player when they're sneaking using CTRL

#Physics Process is run every Physics frame,
#so it's good to do movement etc. in it (to prevent Bethesda-like Physics being dependent on Framerate)
func _physics_process(delta: float) -> void:
	_handle_movement()
	_handle_noise()
	move_and_slide() #Move and Slide is a built in method of CharacterBody2D, and is good because characters gracefully slide against e.g. slopes, instead of just getting stopped

#In Godot, starting a function with an underline is mostly a convenient way of establishing
#private methods - methods starting with an underline aren't shown in external classes (unless explicitly searched for)
#which is useful to prevent clutter

##A Function to Handle Player Movement - movement using WASD/Arrow Keys, Sprinting with SHIFT, Sneaking with CTRL
func _handle_movement() -> void:
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
	#If the Player is not moving (i.e. velocity is 0), Player Noise is 0
	if velocity.length() == 0:
		GameManager.player_noise = 0
	#If the Player's speed is Sneak Speed (i.e. they're sneaking), Player Noise is 0
	elif velocity.length() == sneak_speed:
		GameManager.player_noise = 0
	#If the Player's speed is Sprint Speed (i.e. they're sprinting), Player Noise is 2
	elif velocity.length() == sprint_speed:
		GameManager.player_noise = 2
	#Otherwise, Player noise is 1
	else:
		GameManager.player_noise = 1
