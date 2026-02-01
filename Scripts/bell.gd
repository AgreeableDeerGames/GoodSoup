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
	
	# Create report to click
	_create_flavor_report(soup, poison, ingredients)
	
	# The ingredients gets captured. Call this on the newly instatiated scene
	var setup_fn = func (x : FlavorReport): x.setup_scene(ingredients, soup, poison, false)
	
	Signals.emit_signal("load_new_scene", "res://Scenes/flavor_report.tscn", false, setup_fn)

func _create_flavor_report(soup : FlavorData, poison : FlavorData, ingredients : Array[Ingredient]):
	var flavor_reports = get_parent().get_node("FlavorReports")
	var flavorReportButton : ViewFlavorReport = load("res://Scenes/view_flavor_report.tscn").instantiate()
	flavorReportButton.setup(soup, poison, ingredients)
	flavorReportButton.custom_minimum_size.x = flavor_reports.custom_minimum_size.x
	flavorReportButton.custom_minimum_size.y = flavor_reports.custom_minimum_size.y
	get_parent().get_node("FlavorReports").add_child(flavorReportButton)
	
	
