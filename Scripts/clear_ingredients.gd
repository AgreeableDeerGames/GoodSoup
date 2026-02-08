extends Button


func _on_pressed() -> void:
	var ingredientsNode : Node = get_parent().get_node("Ingredients")
	for ingredient in ingredientsNode.get_children():
		# From online, this does not seem to invalidate the iterator... which is nice
		ingredientsNode.remove_child(ingredient)
		ingredient.queue_free()
