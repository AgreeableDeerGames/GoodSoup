extends Button



func _on_pressed() -> void:
	# Pass the report stuff into this
	Signals.emit_signal("load_new_scene", "res://Scenes/kitchen.tscn", true)
