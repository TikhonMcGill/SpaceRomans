extends Node

##Variable to hold the list of gameplay modifiers 
var gameplay_modifiers = [
	Modifier.new("Rage", "Enemies kill you instantly."),
	Modifier.new("Juggernaut", "Enemies have twice as much HP."),
	Modifier.new("Taxed", "Enemy movement speed is greatly reduced."),
	Modifier.new("Olive Branch", "Player deals half damage per shot."), 
	Modifier.new("Assassin", "Player movement speed while sneaking is doubled."), 
	Modifier.new("Sharpshooter", "Player shooting kills instantly and has double the shooting range."),
	Modifier.new("Gladiator", "Player has double HP."),
	Modifier.new("Phantom", "Player makes 2x less noise while walking and sprinting."),
	]

##Method to select a random gameplay modifier
func _select_random_gameplay_modifier() -> Modifier:
	return gameplay_modifiers.pick_random() ##Return the randomly selected gameplay_modifier

func _reset_modifiers() -> void:
	GameManager._set_enemy_damage(GameManager.BASE_ENEMY_DAMAGE)
	GameManager._set_enemy_health(GameManager.BASE_ENEMY_HEALTH)
	GameManager._set_enemy_movement_and_patrol_speed(GameManager.BASE_ENEMY_SPEED,GameManager.BASE_ENEMY_PATROL_SPEED)
	GameManager._set_player_damage(GameManager.BASE_PLAYER_DAMAGE)
	GameManager._set_player_sneak_speed(GameManager.BASE_PLAYER_SNEAK_SPEED)
	GameManager._set_player_shoot_range(GameManager.BASE_PLAYER_SHOOT_RANGE)
	GameManager._set_player_health(GameManager.BASE_PLAYER_HEALTH)
	GameManager._set_player_walk_and_sprint_noise(GameManager.BASE_PLAYER_WALK_NOISE,GameManager.BASE_PLAYER_SPRINT_NOISE)

##Method to activate the selected gameplay modifier
func _activate_gameplay_modifier(gameplay_modifier: Modifier):
	print("Activating gameplay modifier: ", gameplay_modifier.modifier_name) ##Used for eventual debugging/tracking
	
	if gameplay_modifier.modifier_name == "Rage": ##Test for Rage gameplay modifier effect
		GameManager._set_enemy_damage(100)
	elif gameplay_modifier.modifier_name == "Juggernaut": ##Test for Juggernaut gameplay modifier effect
		GameManager._set_enemy_health(200)
	elif gameplay_modifier.modifier_name == "Taxed": ##Test for Taxed gameplay modifier effect
		GameManager._set_enemy_movement_and_patrol_speed(50,25)
	elif gameplay_modifier.modifier_name == "Olive Branch": ##Test for Olive Branch gameplay modifier effect
		GameManager._set_player_damage(5)
	elif gameplay_modifier.modifier_name == "Assassin": ##Test for Assassin gameplay modifier effect
		GameManager._set_player_sneak_speed(150) 
	elif gameplay_modifier.modifier_name == "Sharpshooter": ##Test for Sharpshooter gameplay modifier effect
		GameManager._set_player_damage(100)
		GameManager._set_player_shoot_range(256) 
	elif gameplay_modifier.modifier_name == "Gladiator": ##Test for Gladiator gameplay modifier effect
		GameManager._set_player_health(200) 
	elif gameplay_modifier.modifier_name == "Phantom": ##Test for Phantom gameplay modifier effect
		GameManager._set_player_walk_and_sprint_noise(16,32)
