extends Node2D

class_name FlavorReport
#@onready var ingredients_ui: GridContainer = $CanvasGroup/IngredientsUI
@onready var ingredients_ui: GridContainer = $CenterContainer/CanvasGroup/IngredientsUI

@export
var _ingredients : Array[Ingredient]
@export
var base_soup_flavor_data : FlavorData
@export
var _poison_flavor_data : FlavorData
@export
var _ingredients_flavor_data : FlavorData

func setup_scene(ingredients : Array[Ingredient], base_Soup_flavor_data_init: FlavorData, poision_flavor_data: FlavorData, is_play: bool) -> void:
	_ingredients = ingredients
	base_soup_flavor_data = base_Soup_flavor_data_init
	_poison_flavor_data = poision_flavor_data
	_is_play = is_play
	if (is_play):
		$BackButton.hide()
		$BackButton/HBoxContainer/Button.disabled = true
		$KitchenButton.show()
		$KitchenButton/HBoxContainer/Button.disabled = false
	else:
		
		$BackButton.show()
		$BackButton/HBoxContainer/Button.disabled = false
		$KitchenButton.hide()
		$KitchenButton/HBoxContainer/Button.disabled = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# First Generate the data from the ingredients
	_populate_flavor_data()
	# Create UI
	generate_radar_chart()
	_generate_flavor_pentagon($CenterContainer/FlavorData, 10)
	generate_spice_report($CenterContainer.get_node("FlavorData"))
	_generate_ingredients()

func _central_angle (side_count: int) -> int:
	return 360 / side_count

func _generate_flavor_pentagon(flavor_data: FlavorData, line_width: int):
	# Create the Coordinates for the "pentagon"
	var flavor_pentagon_coords: PackedVector2Array = _pentagon_coords_from_magnitudes(\
		[clampf(flavor_data.sweet, 0, 10), \
		clampf(flavor_data.sour, 0, 10), \
		clampf(flavor_data.salty, 0, 10), \
		clampf(flavor_data.bitter, 0, 10), \
		clampf(flavor_data.umami, 0, 10)], \
		10,
		$CenterContainer.get_node("Sprite2D").position)
	
		
	var flavor_line: Line2D = Line2D.new()
	flavor_line.width = line_width
	flavor_line.points = flavor_pentagon_coords
	flavor_line.closed = true
	flavor_line.default_color = Color.BLACK
	add_child(flavor_line)
	
	
	
func _pentagon_coords_from_magnitudes(magnitudes: Array[float], scale: float, offset: Vector2) -> PackedVector2Array:
	var angle: float = deg_to_rad(_central_angle(magnitudes.size()))
	var angle_offset: float = deg_to_rad(-90);
	var pentagon_coords: PackedVector2Array = []
	for i in range(0, magnitudes.size()):
		var magnitude: float = magnitudes[i] * scale
		pentagon_coords.append(_polar_to_cartesian((i * angle) + angle_offset, magnitude) + offset)
	return pentagon_coords


static func _polar_to_cartesian(angle: float, radius: float) -> Vector2:
	return Vector2(cos(angle) * radius, sin(angle) * radius)

func generate_radar_chart() -> void:
	var max_pentagon_data = FlavorData.new();
	max_pentagon_data.sweet = FlavorData.MAX_FLAVOR
	max_pentagon_data.sour = FlavorData.MAX_FLAVOR
	max_pentagon_data.salty = FlavorData.MAX_FLAVOR
	max_pentagon_data.bitter = FlavorData.MAX_FLAVOR
	max_pentagon_data.umami = FlavorData.MAX_FLAVOR
	_generate_flavor_pentagon(max_pentagon_data, 5)
	
	var half_pentagon_data = FlavorData.new();
	half_pentagon_data.sweet = FlavorData.MAX_FLAVOR / 2
	half_pentagon_data.sour = FlavorData.MAX_FLAVOR / 2
	half_pentagon_data.salty = FlavorData.MAX_FLAVOR / 2
	half_pentagon_data.bitter = FlavorData.MAX_FLAVOR / 2
	half_pentagon_data.umami = FlavorData.MAX_FLAVOR / 2
	_generate_flavor_pentagon(half_pentagon_data, 3)
	
	var third_pentagon_data = FlavorData.new();
	third_pentagon_data.sweet = FlavorData.MAX_FLAVOR / 4
	third_pentagon_data.sour = FlavorData.MAX_FLAVOR / 4
	third_pentagon_data.salty = FlavorData.MAX_FLAVOR / 4
	third_pentagon_data.bitter = FlavorData.MAX_FLAVOR / 4
	third_pentagon_data.umami = FlavorData.MAX_FLAVOR / 4
	_generate_flavor_pentagon(third_pentagon_data, 1)
	
	
	var fourth_pentagon_data = FlavorData.new();
	fourth_pentagon_data.sweet = FlavorData.MAX_FLAVOR * 3 / 4
	fourth_pentagon_data.sour = FlavorData.MAX_FLAVOR * 3 / 4
	fourth_pentagon_data.salty = FlavorData.MAX_FLAVOR * 3 / 4
	fourth_pentagon_data.bitter = FlavorData.MAX_FLAVOR * 3 / 4
	fourth_pentagon_data.umami = FlavorData.MAX_FLAVOR * 3 / 4
	_generate_flavor_pentagon(fourth_pentagon_data, 1)
	
func generate_spice_report(flavor_data: FlavorData) -> void:
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _generate_ingredients():
	for ingredient in _ingredients:
		var ingredientTexture = ingredient.get_node("Sprite2D").texture
		var textureRect : TextureRect = TextureRect.new()
		textureRect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		textureRect.texture = ingredientTexture
		textureRect.custom_minimum_size.x = ingredients_ui.custom_minimum_size.x
		textureRect.custom_minimum_size.y = ingredients_ui.custom_minimum_size.y
		ingredients_ui.add_child(textureRect)

func _populate_flavor_data():
	if _is_play:
		$CenterContainer/FlavorData.copy_from(_base_soup_flavor_data)
	else:
		_populate_ingredient_flavor_data()
		_combine_flavor_data()
	
func _populate_ingredient_flavor_data():
	_ingredients_flavor_data = FlavorData.new()
	for ingredient in _ingredients:
		_ingredients_flavor_data.sour += ingredient.get_node("FlavorData").sour
		_ingredients_flavor_data.sweet += ingredient.get_node("FlavorData").sweet
		_ingredients_flavor_data.salty += ingredient.get_node("FlavorData").salty
		_ingredients_flavor_data.bitter += ingredient.get_node("FlavorData").bitter
		# For some reason it does not like unami
		#_ingredients_flavor_data.umami += ingredient.get_node("FlavorData").unami
		_ingredients_flavor_data.numbing_spice += ingredient.get_node("FlavorData").numbing_spice
		_ingredients_flavor_data.hot_spice += ingredient.get_node("FlavorData").hot_spice
		_ingredients_flavor_data.nasal_spice += ingredient.get_node("FlavorData").nasal_spice
		#$FlavorData.richness += ingredient.get_node("FlavorData").richness
		#$FlavorData.acidity += ingredient.get_node("FlavorData").acidity
	
	# Get the average
	_ingredients_flavor_data.sour /= _ingredients.size()
	_ingredients_flavor_data.sweet /= _ingredients.size()
	_ingredients_flavor_data.salty /= _ingredients.size()
	_ingredients_flavor_data.bitter /= _ingredients.size()
	#_ingredients_flavor_data.umami /= _ingredients.size()
	_ingredients_flavor_data.numbing_spice /= _ingredients.size()
	_ingredients_flavor_data.hot_spice /= _ingredients.size()
	_ingredients_flavor_data.nasal_spice /= _ingredients.size()
	#_ingredients_flavor_data.richness /= _ingredients.size()
	#_ingredients_flavor_data.acidity /= _ingredients.size()

func _combine_flavor_data():
	$CenterContainer/FlavorData.sour = _ingredients_flavor_data.sour + base_soup_flavor_data.sour + _poison_flavor_data.sour
	$CenterContainer/FlavorData.sweet = _ingredients_flavor_data.sweet + base_soup_flavor_data.sweet + _poison_flavor_data.sweet
	$CenterContainer/FlavorData.salty = _ingredients_flavor_data.salty + base_soup_flavor_data.salty + _poison_flavor_data.salty
	$CenterContainer/FlavorData.bitter = _ingredients_flavor_data.bitter + base_soup_flavor_data.bitter + _poison_flavor_data.bitter
	$CenterContainer/FlavorData.umami = _ingredients_flavor_data.umami + base_soup_flavor_data.umami + _poison_flavor_data.umami
	$CenterContainer/FlavorData.numbing_spice = _ingredients_flavor_data.numbing_spice + base_soup_flavor_data.numbing_spice + _poison_flavor_data.numbing_spice
	$CenterContainer/FlavorData.hot_spice = _ingredients_flavor_data.hot_spice + base_soup_flavor_data.hot_spice + _poison_flavor_data.hot_spice
	$CenterContainer/FlavorData.nasal_spice = _ingredients_flavor_data.nasal_spice + base_soup_flavor_data.nasal_spice + _poison_flavor_data.nasal_spice
	$CenterContainer/FlavorData.richness = _ingredients_flavor_data.richness + base_soup_flavor_data.richness + _poison_flavor_data.richness
	$CenterContainer/FlavorData.acidity = _ingredients_flavor_data.acidity + base_soup_flavor_data.acidity + _poison_flavor_data.acidity
	
