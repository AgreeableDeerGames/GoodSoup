extends TextureButton
class_name ViewFlavorReport

var _soup : FlavorData
var _poison : FlavorData
var _ingredients : Array[Ingredient]

func setup(soup, poison, ingredients):
	_soup = soup
	_poison = poison
	_ingredients = ingredients
	
func _ready():
	pass

func _on_pressed() -> void:	
	# The ingredients gets captured. Call this on the newly instatiated scene
	var setup_fn = func (x : FlavorReport): x.setup_scene(_ingredients, _soup, _poison, false)
	
	Signals.emit_signal("load_new_scene", "res://Scenes/flavor_report.tscn", false, setup_fn)
