extends TextureButton


func _on_pressed() -> void:
	var cauldron = self.get_parent().get_node("Cauldron")
	var ingredientsNodes : Array[Node] = cauldron.get_node("Ingredients").get_children()
	var ingredients : Array[Ingredient]
	for node in ingredientsNodes:
		if typeof(node) == typeof(Ingredient):
			var i : Ingredient = node
			ingredients.append(i)
			
	var soup : FlavorData = FlavorData.new()
	var poison : FlavorData = get_parent().poison
	
	# The ingredients gets captured. Call this on the newly instatiated scene
	var setup_fn = func (x : FlavorReport): x.setup_scene(ingredients, soup, poison, false)
	
	Signals.emit_signal("load_new_scene", "res://Scenes/flavor_report.tscn", false, setup_fn)
