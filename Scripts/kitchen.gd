extends Node2D

class_name Kitchen

var poison : FlavorData
var _soup : FlavorData
func setup_scene(soup: FlavorData):
	_soup = soup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	poison = FlavorData.new()
	poison.generate_values()
	
	var emptyIngredients : Array[Ingredient] = []
	var empty : FlavorData = FlavorData.new()
	
	get_node("Bell").create_flavor_report(_soup, empty, emptyIngredients)
