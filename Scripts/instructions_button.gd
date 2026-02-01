extends Button


func _on_pressed() -> void:
	Signals.emit_signal("load_new_scene","res://Scenes/instructions.tscn", false)
