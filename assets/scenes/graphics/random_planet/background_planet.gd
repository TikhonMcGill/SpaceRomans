extends Node2D

class_name BackgroundPlanet

const SURFACES := [
	preload("res://assets/scenes/graphics/random_planet/smooth_surface.png"),
	preload("res://assets/scenes/graphics/random_planet/rough_surface.png")
]

const POPULATIONS := [
	preload("res://assets/scenes/graphics/random_planet/population_sprites/low_population.png"),
	preload("res://assets/scenes/graphics/random_planet/population_sprites/medium_population.png"),
	preload("res://assets/scenes/graphics/random_planet/population_sprites/high_population.png")
]

@onready var planet_surface: Sprite2D = $PlanetSurface
@onready var planet_population: Sprite2D = $PlanetPopulation

func randomize_planet() -> void:
	planet_surface.texture = SURFACES.pick_random()
	
	var have_population : bool = [true,true,false].pick_random()
	
	if have_population == true:
		planet_population.visible = true
		planet_population.texture = POPULATIONS.pick_random()
	else:
		planet_population.visible = false
	
	planet_surface.modulate = Color8(randi_range(100,255),randi_range(100,255),randi_range(100,255))
	
	scale = Vector2.ONE * randf_range(0.25,10)
