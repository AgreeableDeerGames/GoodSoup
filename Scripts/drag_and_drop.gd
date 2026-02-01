extends Node2D

var is_draggable: bool = false
var is_in_drag: bool = false
var is_being_dropped: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_parent().
	pass # Replace with function body.

func set_size(new_size: Vector2) -> void:
	$Control.size = new_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If picked up follow the mouse
	if is_in_drag:
		#move to mouse position
		get_parent().position = get_viewport().get_mouse_position();
	if (is_being_dropped):
		# determine if it can go into cauldron, else send it back to the start (or just delete whatever)
		pass
	pass

func _input(event: InputEvent) -> void:
	# If grabbable, set to grabbed
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and is_draggable:
			is_in_drag = true;
			#print("I've been clicked at: " + str(event.position))
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed and is_draggable:
			is_in_drag = false;
			is_being_dropped = true;
