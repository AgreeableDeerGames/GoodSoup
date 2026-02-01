extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_generate_flavor_pentagon($FlavorData)

func _central_angle (side_count: int) -> int:
	return 360 / side_count

func _generate_flavor_pentagon(flavor_data: FlavorData):
	var flavor_pentagon_coords: PackedVector2Array = _pentagon_coords_from_magnitudes(\
		[flavor_data.sweet, \
		flavor_data.sour, \
		flavor_data.salty, \
		flavor_data.bitter, \
		flavor_data.umami], \
		10,
		$Sprite2D.position)
	
	var scale = 10
		
	var flavor_line: Line2D = Line2D.new()
	flavor_line.points = flavor_pentagon_coords
	flavor_line.closed = true
	flavor_line.default_color = Color.BLACK
	add_child(flavor_line)
	
	var regular_pentagon_coords : PackedVector2Array = _pentagon_coords_from_magnitudes(\
		[FlavorData.MAX_FLAVOR, \
		FlavorData.MAX_FLAVOR, \
		FlavorData.MAX_FLAVOR, \
		FlavorData.MAX_FLAVOR, \
		FlavorData.MAX_FLAVOR], \
		scale, \
		$Sprite2D.position)
		
	var flavor_base_line: Line2D = Line2D.new()
	flavor_base_line.points = regular_pentagon_coords
	flavor_base_line.closed = true
	flavor_base_line.default_color = Color.BLACK
	add_child(flavor_base_line)
	
	var label_offset: float = 0.2
	var flavor_pentagon_label_coords: PackedVector2Array = _pentagon_coords_from_magnitudes(\
		[FlavorData.MAX_FLAVOR + label_offset, \
		FlavorData.MAX_FLAVOR + label_offset, \
		FlavorData.MAX_FLAVOR + label_offset, \
		FlavorData.MAX_FLAVOR + label_offset, \
		FlavorData.MAX_FLAVOR + label_offset], \
		scale, \
		$Sprite2D.position)
	var label_array: Array[String] = ["sweet", "sour", "salty", "bitter", "umami"]
	for i in range(0, label_array.size()):
		var label: Label = Label.new()
		label.text = label_array[i]
		label.position = flavor_pentagon_label_coords[i]
		add_child(label)
	
	
func _pentagon_coords_from_magnitudes(magnitudes: Array[float], scale: float, offset: Vector2):
	var angle: float = deg_to_rad(_central_angle(magnitudes.size()))
	var angle_offset: float = deg_to_rad(-90);
	var pentagon_coords: PackedVector2Array = []
	for i in range(0, magnitudes.size()):
		var magnitude: float = magnitudes[i] * scale
		pentagon_coords.append(_polar_to_cartesian((i * angle) + angle_offset, magnitude) + offset)
	return pentagon_coords
		
static func _polar_to_cartesian(angle: float, radius: float) -> Vector2:
	return Vector2(cos(angle) * radius, sin(angle) * radius)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
