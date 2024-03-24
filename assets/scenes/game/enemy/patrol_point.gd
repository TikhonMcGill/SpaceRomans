extends Node2D

class_name PatrolPoint

func _ready() -> void:
	#Delete the Icon - we only need to see it in the editor
	$Icon.queue_free()
