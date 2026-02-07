extends Button

func _on_pressed() -> void:
	# Pass the report stuff into this
	var soup : FlavorData = FlavorData.new();
	var parent = get_parent().get_parent().get_parent().get_node("CenterContainer")
	var flavorData = parent.get_node("FlavorData")
	soup.sweet = flavorData.sweet
	soup.sour = flavorData.sour
	soup.salty = flavorData.salty
	soup.umami = flavorData.umami
	soup.bitter = flavorData.bitter
	soup.numbing_spice = flavorData.numbing_spice
	soup.hot_spice = flavorData.hot_spice
	soup.richness = flavorData.richness
	soup.acidity = flavorData.acidity
	
	var setup_fn = func (x : Kitchen): x.setup_scene(soup)
	Signals.emit_signal("load_new_scene", "res://Scenes/kitchen.tscn", true, setup_fn)
