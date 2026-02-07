@tool
extends Node2D

@export
var clickable_area: Rect2

var is_draggable: bool = false
var is_in_drag: bool = false
var is_being_dropped: bool = false

var original_position: Vector2 = Vector2.ZERO
var has_spawned_replacement: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = get_parent().position
	#get_parent().
	$Control.size = clickable_area.size
	$Control.position = clickable_area.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If picked up follow the mouse
	if is_in_drag:
		#move to mouse position
		var mousePosition: Vector2 = get_viewport().get_mouse_position()
		get_parent().position = mousePosition;
		# 
		if !has_spawned_replacement && mousePosition.distance_to(original_position) > 100:
			var clone = get_parent().duplicate()
			clone.position = original_position
			get_parent().get_parent().add_child(clone)
			has_spawned_replacement = true
	if (is_being_dropped):
		# determine if it can go into cauldron, else send it back to the start (or just delete whatever)
		
		pass
	pass

func _input(event: InputEvent) -> void:
	# If grabbable, set to grabbed
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and is_draggable:
			is_in_drag = true;
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed and is_draggable:
			is_in_drag = false;
			is_being_dropped = true;
			# Delete this object if it is not in the cauldron
			var grandparent : Node = get_parent().get_parent()
			if grandparent is not Cauldron:
				if has_spawned_replacement:
					get_parent().queue_free()
				else:
					get_parent().position = original_position
			
func _draw():
	if Engine.is_editor_hint():
		draw_rect(clickable_area, Color.RED, false, 5)
