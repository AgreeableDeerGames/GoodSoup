extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _generate_target_flavor_data() -> FlavorData:
	var target_data = FlavorData.new()
	var rng = RandomNumberGenerator.new()
	const MAX_TARGET_VALUE: int = 6
	target_data.sour = rng.randf_range(0, MAX_TARGET_VALUE)
	target_data.sweet = rng.randf_range(0, MAX_TARGET_VALUE)
	target_data.salty = rng.randf_range(0, MAX_TARGET_VALUE)
	target_data.bitter = rng.randf_range(0, MAX_TARGET_VALUE)
	target_data.umami = rng.randf_range(0, MAX_TARGET_VALUE)
	target_data.numbing_spice = rng.randf_range(0, MAX_TARGET_VALUE)
	target_data.hot_spice = rng.randf_range(0, MAX_TARGET_VALUE)
	target_data.nasal_spice = rng.randf_range(0, MAX_TARGET_VALUE)
	return target_data

func _on_pressed() -> void:
	#Signals.emit_signal("load_new_scene", "res://Scenes/kitchen.tscn", true)
	
	# Empty ingredients
	var ingredients : Array[Ingredient]
	# Randomize soup
	var soup : FlavorData = _generate_target_flavor_data()
	# No Poison
	var poison : FlavorData = FlavorData.new()
	
	# The ingredients gets captured. Call this on the newly instatiated scene
	var setup_fn = func (x : FlavorReport): x.setup_scene(ingredients, soup, poison, true)
	Signals.emit_signal("load_new_scene", "res://Scenes/Flavor_Report.tscn", true, setup_fn)
