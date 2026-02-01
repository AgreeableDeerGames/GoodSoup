extends Button



func _on_pressed() -> void:
	Signals.emit_signal("back_to_previous_scene")
