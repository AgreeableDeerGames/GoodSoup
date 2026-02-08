extends Button

func _on_pressed() -> void:
	Signals.emit_signal("load_new_scene","res://Scenes/main_menu.tscn", true)
