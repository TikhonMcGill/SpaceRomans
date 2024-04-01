extends Node

@export var latin_words : Array[String] = [
	"Caesar","Augustus","Maximus","Impervius",
	"Pulcher","Invictus","Imperator","Magnus",
	"Optimus","Magister","Dominus","Princeps",
	"Romanus","Praetorianus"
]

#RNS stands for "Romana Navis Spatii", which is Latin for "Roman Ship of Space", according to
#Google Translate
func generate_ship_name() -> String:
	return "RNS \"%s\"" % latin_words.pick_random()

func generate_planet_name() -> String:
	var vowels = ["a","e","i","u","a","e","i","u","ae","ei"]
	var consonants = ["b","c","d","ph","l","ll","sc","r","m","n","t","p","qu","v"]
	
	var result : String = ""
	var is_vowel = [true,false].pick_random()
	
	var name_size := randi_range(4,8)
	
	for x in range(name_size):
		if is_vowel == true:
			if x == name_size-1:
				result += ["ia","ium","a","um","i","ii"].pick_random()
			else:
				result += vowels.pick_random()
		else:
			result += consonants.pick_random()
			if x == name_size-1:
				result += ["ia","ium","a","um","i","ii","us"].pick_random()
		
		is_vowel = not is_vowel
	
	while result.contains("iii") == true:
		result = result.replace("iii","ii")
	
	if result.begins_with("ll") == true:
		result = result.trim_prefix("ll")
		result = "l" + result
	
	return result.capitalize()
