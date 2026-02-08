extends Button




func _on_pressed() -> void:
	Signals.emit_signal("load_new_scene","res://Scenes/help_menu.tscn", false)
