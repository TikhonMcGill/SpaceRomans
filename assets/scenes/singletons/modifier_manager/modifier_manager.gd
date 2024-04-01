extends Node

##Variable to hold the list of gameplay modifiers 
var gameplay_modifiers = [
	Modifier.new("Rage", "Enemies deal 100 Damage per shot."),
	Modifier.new("Juggernaut", "Enemies have 200HP."),
	Modifier.new("Taxed", "Enemy movement speed is greatly reduced."),
	Modifier.new("Olive Branch", "Player deals 0 damage per shot."), 
	Modifier.new("Assassin", "Player movement speed while sneaking is doubled."), 
	Modifier.new("Sharpshooter", "Player deals 100 damage per shot and has double the shooting range."),
	Modifier.new("Gladiator", "Player has 200HP."),
	##TODO Add additional gameplay modifiers
	Modifier.new("Phantom", "Player makes 2x less noise while walking and sprinting."),
	]

##Method to select a random gameplay modifier
func _select_random_gameplay_modifier() -> Modifier:
	return gameplay_modifiers.pick_random() ##Return the randomly selected gameplay_modifier

##Method to activate the selected gameplay modifier
func _activate_gameplay_modifier(gameplay_modifier: Modifier):
	print("Activating gameplay modifier: ", gameplay_modifier.modifier_name) ##Used for eventual debugging/tracking
	##TODO Add code to apply the effect of the gameplay modifier in game
	
	if gameplay_modifier.modifier_name == "Rage": ##Test for Rage gameplay modifier effect
		GameManager._set_enemy_damage(100)
	elif gameplay_modifier.modifier_name == "Juggernaut": ##Test for Juggernaut gameplay modifier effect
		GameManager._set_enemy_health(200)
	elif gameplay_modifier.modifier_name == "Taxed": ##Test for Taxed gameplay modifier effect
		GameManager._set_enemy_movement_and_patrol_speed(50,25)
	elif gameplay_modifier.modifier_name == "Olive Branch": ##Test for Olive Branch gameplay modifier effect
		GameManager._set_player_damage(0)
	elif gameplay_modifier.modifier_name == "Assassin": ##Test for Assassin gameplay modifier effect
		GameManager._set_player_sneak_speed(150) 
	elif gameplay_modifier.modifier_name == "Sharpshooter": ##Test for Sharpshooter gameplay modifier effect
		GameManager._set_player_damage(100)
		GameManager._set_player_shoot_range(256) 
	elif gameplay_modifier.modifier_name == "Gladiator": ##Test for Gladiator gameplay modifier effect
		GameManager._set_player_health(200) 
	elif gameplay_modifier.modifier_name == "Phantom": ##Test for Phantom gameplay modifier effect
		GameManager._set_player_walk_and_sprint_noise(16,32) 

##Method to apply the gameplay modifier at runtime in-game
func _ready():
	var chosen_gameplay_modifier = _select_random_gameplay_modifier() ##Select and store a random gameplay modifier
	_activate_gameplay_modifier(chosen_gameplay_modifier) ##Call method to apply the chosen gameplay modifier in-game
