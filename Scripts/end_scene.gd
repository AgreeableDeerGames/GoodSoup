extends Control

class_name EndScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _make_flavor_data(value: float) -> FlavorData:
	var fd1 = FlavorData.new()
	fd1.sweet = value
	fd1.sour = value
	fd1.salty = value
	fd1.bitter = value
	fd1.umami = value
	fd1.hot_spice = value
	fd1.nasal_spice = value
	fd1.numbing_spice = value
	return fd1


func setup_scene(target_soup_flavor_data: FlavorData, final_soup_flavor_data: FlavorData) -> void:
	# Determine success by comparing
	var success: bool = false
	
	var tolerance: FlavorData = _make_flavor_data(.5)
	success = target_soup_flavor_data.flavor_equal_with_tolerance(final_soup_flavor_data, tolerance)
	
	if success:
		$VictoryBox.show()
		$DefeatBox.hide()
	else:
		$VictoryBox.hide()
		$DefeatBox.show()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
