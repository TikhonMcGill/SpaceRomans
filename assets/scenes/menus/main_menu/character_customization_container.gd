extends ScrollContainer

@onready var character_graphic: CharacterGraphic = $VBoxContainer/HBoxContainer/Control/CharacterGraphic

@onready var skin_color_picker_button: ColorPickerButton = $VBoxContainer/SkinColorPickerButton
@onready var clothing_color_picker_button: ColorPickerButton = $VBoxContainer/ClothingColorPickerButton

var angle : float = 0

func _ready() -> void:
	angle = 0
	skin_color_picker_button.color = GameManager.player_skin_color
	clothing_color_picker_button.color = GameManager.player_clothing_color

func _process(delta: float) -> void:
	if visible == false:
		return
	
	angle += 45 * delta
	character_graphic.update_rotation(angle)
	character_graphic.set_skin_color(skin_color_picker_button.color)
	character_graphic.set_clothing_color(clothing_color_picker_button.color)

func _get_random_color() -> Color:
	return Color8(randi_range(0,255),randi_range(0,255),randi_range(0,255))

func _on_random_skin_color_button_pressed() -> void:
	var color : Color = CharacterGraphic.HUMAN_SKIN_COLORS.pick_random()
	
	if randi() % 10 == 0:
		color = _get_random_color()
	
	skin_color_picker_button.color = color

func _on_random_clothing_color_button_pressed() -> void:
	clothing_color_picker_button.color = _get_random_color()

func _on_hidden() -> void:
	GameManager.player_skin_color = skin_color_picker_button.color
	GameManager.player_clothing_color = clothing_color_picker_button.color
