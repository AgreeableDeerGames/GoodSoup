extends Button

func _on_pressed() -> void:
	var ingredient = load("res://Scenes/ingredient.tscn").instantiate()
	ingredient.get_node("Sprite2D").texture = load("res://Assets/PoisonBottle.png")
	ingredient.get_node("FlavorData").sour = 1
	ingredient.get_node("FlavorData").sweet = 1
	ingredient.get_node("FlavorData").salty = 1
	ingredient.get_node("FlavorData").bitter = 1
	ingredient.get_node("FlavorData").umami = 1.0
	ingredient.get_node("FlavorData").numbing_spice = 1
	ingredient.get_node("FlavorData").hot_spice = 1
	ingredient.get_node("FlavorData").nasal_spice = 1
	
	var ingredients : Array[Ingredient] = [ingredient]
	var soup = get_parent().get_node("Soup")
	var poison = get_parent().get_node("Poison")
	
	# The ingredients gets captured. Call this on the newly instatiated scene
	var setup_fn = func (x : FlavorReport): x.setup_scene(ingredients, soup, poison)
	
	Signals.emit_signal("load_new_scene", "res://Scenes/flavor_report.tscn", false, setup_fn)
