extends Node2D

var tasters: Array[Sprite2D]

func remove_taster() -> void:
	remove_child(tasters.back())
	tasters.pop_back()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tasters = [$Taster1, $Taster2, $Taster3, $Taster4, ]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
