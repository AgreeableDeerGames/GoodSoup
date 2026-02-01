extends FlavorReport

class_name Recipe

const Ingredients = preload("res://Scripts/ingredients_stub.gd")

var _ingredients : Array[Ingredients]
	
# called with new	
func _init(ingredients : Array[Ingredients], ) -> void:
	_ingredients = ingredients
	
func _populate_flavor_data():
	for ingredient in _ingredients:
		$FlavorData.sour += ingredient.get_node("FlavorData").sour
		$FlavorData.sweet += ingredient.get_node("FlavorData").sweet
		$FlavorData.salty += ingredient.get_node("FlavorData").salty
		$FlavorData.bitter += ingredient.get_node("FlavorData").bitter
		$FlavorData.umami += ingredient.get_node("FlavorData").unami
		$FlavorData.numbing_spice += ingredient.get_node("FlavorData").numbing_spice
		$FlavorData.hot_spice += ingredient.get_node("FlavorData").hot_spice
		$FlavorData.nasal_spice += ingredient.get_node("FlavorData").nasal_spice
		$FlavorData.richness += ingredient.get_node("FlavorData").richness
		$FlavorData.acidity += ingredient.get_node("FlavorData").acidity
		
	$FlavorData.sour /= _ingredients.size()
	$FlavorData.sweet /= _ingredients.size()
	$FlavorData.salty /= _ingredients.size()
	$FlavorData.bitter /= _ingredients.size()
	$FlavorData.umami /= _ingredients.size()
	$FlavorData.numbing_spice /= _ingredients.size()
	$FlavorData.hot_spice /= _ingredients.size()
	$FlavorData.nasal_spice /= _ingredients.size()

func 
