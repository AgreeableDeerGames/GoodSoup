extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	#Signals.emit_signal("load_new_scene", "res://Scenes/kitchen.tscn", true)
	
	# Empty ingredients
	var ingredients : Array[Ingredient]
	# Randomize soup
	var soup : FlavorData = FlavorData.new()
	# No Poison
	var poison : FlavorData = FlavorData.new()
	
	# The ingredients gets captured. Call this on the newly instatiated scene
	var setup_fn = func (x : FlavorReport): x.setup_scene(ingredients, soup, poison, true)
	Signals.emit_signal("load_new_scene", "res://Scenes/Flavor_Report.tscn", true, setup_fn)
