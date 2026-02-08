extends Node2D

class_name Kitchen

var poison : FlavorData
var _soup : FlavorData
func setup_scene(soup: FlavorData):
	_soup = soup

func generate_poison() -> FlavorData:
	poison = FlavorData.new()
	const MAX_TARGET_VALUE: int = 6
	const MIN_TARGET_VALUE: int = 0
	var rng = RandomNumberGenerator.new()
	poison.sour = rng.randf_range(MIN_TARGET_VALUE, MAX_TARGET_VALUE)
	poison.sweet = rng.randf_range(MIN_TARGET_VALUE, MAX_TARGET_VALUE)
	poison.salty = rng.randf_range(MIN_TARGET_VALUE, MAX_TARGET_VALUE)
	poison.bitter = rng.randf_range(MIN_TARGET_VALUE, MAX_TARGET_VALUE)
	poison.umami = rng.randf_range(MIN_TARGET_VALUE, MAX_TARGET_VALUE)
	poison.numbing_spice = rng.randf_range(MIN_TARGET_VALUE, MAX_TARGET_VALUE)
	poison.hot_spice = rng.randf_range(MIN_TARGET_VALUE, MAX_TARGET_VALUE)
	poison.nasal_spice = rng.randf_range(MIN_TARGET_VALUE, MAX_TARGET_VALUE)
	return poison

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	poison = FlavorData.new()
	poison.generate_values()
	
	var emptyIngredients : Array[Ingredient] = []
	var empty : FlavorData = FlavorData.new()
	
	get_node("Bell").create_flavor_report(_soup, empty, emptyIngredients)
