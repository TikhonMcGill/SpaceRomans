extends Label

var showing_message = true

func _ready():
	self.visible = true

func _process(delta):
	if showing_message:
		self.visible = true
	else:
		self.visible = false

func show_message():
	showing_message = true
	text = "Press Right Button to Move Right!"

func hide_message():
	showing_message = false
	text = ""
	
func update_message(message):
	showing_message = true
	text = message
