extends ParallaxBackground

@onready var background_planet: BackgroundPlanet = $Planet/BackgroundPlanet

func _ready() -> void:
	background_planet.randomize_planet()
	background_planet.position = Vector2(randf_range(240,480),randf_range(120,360))
