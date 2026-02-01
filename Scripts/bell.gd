extends TextureButton


func _on_pressed() -> void:
	var cauldron = self.get_parent().get_node("Cauldron")
	var ingredients = cauldron.get_node("Ingredients").get_children()
	var soup = FlavorData.new()
	var poison = get_parent().poison
	
	# The ingredients gets captured. Call this on the newly instatiated scene
	var setup_fn = func (x : FlavorReport): x.setup_scene(ingredients, soup, poison)
	
	Signals.emit_signal("load_new_scene", "res://Scenes/flavor_report.tscn", false, setup_fn)
