extends Area2D

class_name Cauldron

func _on_area_entered(area: Area2D) -> void:
	var ingredient = area.get_parent()
	if ingredient is Ingredient:
		area.get_node("CollisionShape2D").set_deferred("disabled", true)
		ingredient.visible = false
		ingredient.call_deferred("reparent", self.get_node("Ingredients"))
