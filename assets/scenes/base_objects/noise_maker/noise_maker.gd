extends Area2D

class_name NoiseMaker

@export var noise_radius := 10

@onready var noise_circle : CircleShape2D = $CollisionShape2D.shape

func _ready() -> void:
	noise_circle.radius = noise_radius

func _process(delta: float) -> void:
	if noise_circle:
		noise_circle.radius = noise_radius
