extends Area2D

class_name NoiseMaker

@export var noise_radius := 10

@onready var _noise_circle : CircleShape2D = $CollisionShape2D.shape

func _process(delta: float) -> void:
	if _noise_circle and is_equal_approx(_noise_circle.radius,noise_radius) == false:
		_noise_circle.radius = noise_radius
