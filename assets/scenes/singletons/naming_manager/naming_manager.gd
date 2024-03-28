extends Node

@export var latin_words : Array[String] = [
	"Caesar","Augustus","Maximus","Impervius",
	"Pulcher","Invictus","Imperator","Magnus",
	"Optimus"
]

#RNS stands for "Romana Navis Spatii", which is Latin for "Roman Ship of Space", according to
#Google Translate
func generate_ship_name() -> String:
	return "RNS \"%s\"" % latin_words.pick_random()

func _ready() -> void:
	print(generate_ship_name())
