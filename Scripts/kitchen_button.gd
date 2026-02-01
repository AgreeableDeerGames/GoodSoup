extends Button

func _on_pressed() -> void:
	# Pass the report stuff into this
	var soup : FlavorData = FlavorData.new();
	var parent = get_parent().get_parent().get_parent()
	soup.sweet = parent.base_soup_flavor_data.sweet
	soup.sour = parent.base_soup_flavor_data.sour
	soup.salty = parent.base_soup_flavor_data.salty
	soup.umami = parent.base_soup_flavor_data.umami
	soup.bitter = parent.base_soup_flavor_data.bitter
	soup.numbing_spice = parent.base_soup_flavor_data.numbing_spice
	soup.hot_spice = parent.base_soup_flavor_data.hot_spice
	soup.richness = parent.base_soup_flavor_data.richness
	soup.acidity = parent.base_soup_flavor_data.acidity
	
	var setup_fn = func (x : Kitchen): x.setup_scene(soup)
	Signals.emit_signal("load_new_scene", "res://Scenes/kitchen.tscn", true, setup_fn)
