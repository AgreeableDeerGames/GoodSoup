extends TextureButton

func _kill_taster() -> void:
	get_parent().get_node("DeadTasters").kill_taster()
	get_parent().get_node("LiveTasters").kill_taster()

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
	
	if get_parent().get_node("LiveTasters").tasters.size() > 0:
		# Create report to click
		create_flavor_report(soup, poison, ingredients)

		# The ingredients gets captured. Call this on the newly instatiated scene
		var setup_fn = func (x : FlavorReport): x.setup_scene(ingredients, soup, poison, false)
		Signals.emit_signal("load_new_scene", "res://Scenes/flavor_report.tscn", false, setup_fn)
	else:
		# The ingredients gets captured. Call this on the newly instatiated scene
		var final_soup_flavor_report: FlavorReport = FlavorReport.new()
		final_soup_flavor_report._ingredients = ingredients
		final_soup_flavor_report._base_soup_flavor_data = soup
		final_soup_flavor_report._poison_flavor_data = poison
		final_soup_flavor_report._populate_ingredient_flavor_data()
		var final_soup_flavor_data = _combine_flavor_data(final_soup_flavor_report)
		
		# TODO: Change the first soup data to be the target
		var setup_fn = func (x : EndScene): x.setup_scene(final_soup_flavor_data, final_soup_flavor_data)
		Signals.emit_signal("load_new_scene", "res://Scenes/end_scene.tscn", false, setup_fn)
	
	_kill_taster()
	
	

func _combine_flavor_data(final_soup_flavor_report: FlavorReport) -> FlavorData:
	var flavor_data: FlavorData = FlavorData.new()
	flavor_data.sour = final_soup_flavor_report._ingredients_flavor_data.sour + final_soup_flavor_report._base_soup_flavor_data.sour + final_soup_flavor_report._poison_flavor_data.sour
	flavor_data.sweet = final_soup_flavor_report._ingredients_flavor_data.sweet + final_soup_flavor_report._base_soup_flavor_data.sweet + final_soup_flavor_report._poison_flavor_data.sweet
	flavor_data.salty = final_soup_flavor_report._ingredients_flavor_data.salty + final_soup_flavor_report._base_soup_flavor_data.salty + final_soup_flavor_report._poison_flavor_data.salty
	flavor_data.bitter = final_soup_flavor_report._ingredients_flavor_data.bitter + final_soup_flavor_report._base_soup_flavor_data.bitter + final_soup_flavor_report._poison_flavor_data.bitter
	flavor_data.umami = final_soup_flavor_report._ingredients_flavor_data.umami + final_soup_flavor_report._base_soup_flavor_data.umami + final_soup_flavor_report._poison_flavor_data.umami
	flavor_data.numbing_spice = final_soup_flavor_report._ingredients_flavor_data.numbing_spice + final_soup_flavor_report._base_soup_flavor_data.numbing_spice + final_soup_flavor_report._poison_flavor_data.numbing_spice
	flavor_data.hot_spice = final_soup_flavor_report._ingredients_flavor_data.hot_spice + final_soup_flavor_report._base_soup_flavor_data.hot_spice + final_soup_flavor_report._poison_flavor_data.hot_spice
	flavor_data.nasal_spice = final_soup_flavor_report._ingredients_flavor_data.nasal_spice + final_soup_flavor_report._base_soup_flavor_data.nasal_spice + final_soup_flavor_report._poison_flavor_data.nasal_spice
	flavor_data.richness = final_soup_flavor_report._ingredients_flavor_data.richness + final_soup_flavor_report._base_soup_flavor_data.richness + final_soup_flavor_report._poison_flavor_data.richness
	flavor_data.acidity = final_soup_flavor_report._ingredients_flavor_data.acidity + final_soup_flavor_report._base_soup_flavor_data.acidity + final_soup_flavor_report._poison_flavor_data.acidity
	return flavor_data


func create_flavor_report(soup : FlavorData, poison : FlavorData, ingredients : Array[Ingredient]):
	var flavor_reports = get_parent().get_node("FlavorReports")
	var flavorReportButton : ViewFlavorReport = load("res://Scenes/view_flavor_report.tscn").instantiate()
	flavorReportButton.setup(soup, poison, ingredients)
	flavorReportButton.custom_minimum_size.x = flavor_reports.custom_minimum_size.x
	flavorReportButton.custom_minimum_size.y = flavor_reports.custom_minimum_size.y
	get_parent().get_node("FlavorReports").add_child(flavorReportButton)
