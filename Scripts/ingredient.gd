extends Node2D

class_name Ingredient

@export
var ingredient_name : String
@onready var flavor_data: FlavorData = $FlavorData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
