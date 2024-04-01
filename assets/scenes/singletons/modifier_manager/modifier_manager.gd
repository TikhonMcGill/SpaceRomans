extends Node

##Variable to hold the list of gameplay modifiers
var gameplay_modifiers = [
	Modifier.new("Rage", "Enemies deal 100 Damage per shot."),
	##TODO Add additional gameplay modifiers
	
	Modifier.new("Juggernaut", "Enemies have 200HP."),
	
	Modifier.new("Taxed", "Enemy movement speed is reduced."),
	
	##Modifier.new("Olive Branch", "Player deals 0 damage per shot."), ##TODO
	
	]

##Method to select a random gameplay modifier
func _select_random_gameplay_modifier() -> Modifier:
	return gameplay_modifiers.pick_random() ##Return the randomly selected gameplay_modifier

##Method to activate the selected gameplay modifier
func _activate_gameplay_modifier(gameplay_modifier: Modifier):
	print("Activating gameplay modifier: ", gameplay_modifier.modifier_name) ##Used for eventual debugging/tracking
	##TODO Add code to apply the effect of the gameplay modifier in game
	
	if gameplay_modifier.modifier_name == "Rage": ##Test for Rage gameplay modifier effect
		Enemy._set_enemy_damage(100) 
	elif gameplay_modifier.modifier_name == "Juggernaut": ##Test for Juggernaut gameplay modifier effect
		Enemy._set_enemy_health(200)
	elif gameplay_modifier.modifier_name == "Taxed": ##Test for Taxed gameplay modifier effect
		Enemy._set_enemy_speed(50)

##Method to apply the gameplay modifier at runtime in-game
func _ready():
	var chosen_gameplay_modifier = _select_random_gameplay_modifier() ##Select and store a random gameplay modifier
	_activate_gameplay_modifier(chosen_gameplay_modifier) ##Call method to apply the chosen gameplay modifier in-game
