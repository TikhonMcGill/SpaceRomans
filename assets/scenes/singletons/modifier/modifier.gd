extends Resource

## Class for Randomly-Selected Gameplay modifiers
class_name Modifier

var modifier_name: String ##The name of the gameplay modifier
var modifier_description: String ##The description of the gameplay modifier (effect(s))

## Class constructor
func _init(modifier_name: String, modifier_description: String):
		self.modifier_name = modifier_name
		self.modifier_description = modifier_description
