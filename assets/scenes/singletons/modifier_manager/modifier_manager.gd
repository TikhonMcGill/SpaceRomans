extends Node

##Variable to hold the list of gameplay modifiers
var gameplay_modifiers = [
	Modifier.new("Anger", "Enemies deal 100 Damage per shot."),
	##TODO Add additional gameplay modifiers
	]

##Method to select a random gameplay modifier
func _select_random_gameplay_modifier() -> Modifier:
	return gameplay_modifiers.pick_random() ##Return the randomly selected gameplay_modifier

##Method to activate the selected gameplay modifier
func _activate_gameplay_modifier(gameplay_modifier: Modifier):
	print("Activating gameplay modifier: ", gameplay_modifier.modifier_name) ##Used for eventual debugging/tracking
	##TODO Add code to apply the effect of the gameplay modifier in game

##Method to apply the gameplay modifier at runtime in-game
func _ready():
	var chosen_gameplay_modifier = _select_random_gameplay_modifier() ##Select and store a random gameplay modifier
	_activate_gameplay_modifier(chosen_gameplay_modifier) ##Call method to apply the chosen gameplay modifier in-game
