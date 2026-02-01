extends Node2D

var hidden_testers: Array[Sprite2D]

func kill_taster() -> void:
	if hidden_testers.size() > 0:
		hidden_testers.back().visible = true
		hidden_testers.pop_back()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hidden_testers = [$Taster5, $Taster4, $Taster3, $Taster2, $Taster1 ]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
