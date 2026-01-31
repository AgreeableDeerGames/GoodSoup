extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _button_pressed():
	# This shuts the program down (immediately).
	# If we want to close the program more gracefully,
	# use get_tree().set_auto_accept_quit(false) 
	get_tree().quit()
