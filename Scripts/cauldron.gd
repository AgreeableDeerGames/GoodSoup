extends Area2D

func _on_area_entered(area: Area2D) -> void:
	var ingredient = area.get_parent()
	if ingredient is Ingredient:
		area.get_node("CollisionShape2D").disabled = true
		ingredient.visible = false
		ingredient.reparent(self.get_node("Ingredients"))
