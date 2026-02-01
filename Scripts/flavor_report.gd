extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_radar_chart()
	_generate_flavor_pentagon($FlavorData, 10)
	generate_spice_report($FlavorData)
	

func _central_angle (side_count: int) -> int:
	return 360 / side_count

func _generate_flavor_pentagon(flavor_data: FlavorData, line_width: int):
	# Create the Coordinates for the "pentagon"
	var flavor_pentagon_coords: PackedVector2Array = _pentagon_coords_from_magnitudes(\
		[flavor_data.sweet, \
		flavor_data.sour, \
		flavor_data.salty, \
		flavor_data.bitter, \
		flavor_data.umami], \
		10,
		$Sprite2D.position)
	
		
	var flavor_line: Line2D = Line2D.new()
	flavor_line.width = line_width
	flavor_line.points = flavor_pentagon_coords
	flavor_line.closed = true
	flavor_line.default_color = Color.BLACK
	add_child(flavor_line)
	
	
	
func _pentagon_coords_from_magnitudes(magnitudes: Array[float], scale: float, offset: Vector2) -> PackedVector2Array:
	var angle: float = deg_to_rad(_central_angle(magnitudes.size()))
	var angle_offset: float = deg_to_rad(-90);
	var pentagon_coords: PackedVector2Array = []
	for i in range(0, magnitudes.size()):
		var magnitude: float = magnitudes[i] * scale
		pentagon_coords.append(_polar_to_cartesian((i * angle) + angle_offset, magnitude) + offset)
	return pentagon_coords


static func _polar_to_cartesian(angle: float, radius: float) -> Vector2:
	return Vector2(cos(angle) * radius, sin(angle) * radius)

func generate_radar_chart() -> void:
	var max_pentagon_data = FlavorData.new();
	max_pentagon_data.sweet = FlavorData.MAX_FLAVOR
	max_pentagon_data.sour = FlavorData.MAX_FLAVOR
	max_pentagon_data.salty = FlavorData.MAX_FLAVOR
	max_pentagon_data.bitter = FlavorData.MAX_FLAVOR
	max_pentagon_data.umami = FlavorData.MAX_FLAVOR
	_generate_flavor_pentagon(max_pentagon_data, 5)
	
	var half_pentagon_data = FlavorData.new();
	half_pentagon_data.sweet = FlavorData.MAX_FLAVOR / 2
	half_pentagon_data.sour = FlavorData.MAX_FLAVOR / 2
	half_pentagon_data.salty = FlavorData.MAX_FLAVOR / 2
	half_pentagon_data.bitter = FlavorData.MAX_FLAVOR / 2
	half_pentagon_data.umami = FlavorData.MAX_FLAVOR / 2
	_generate_flavor_pentagon(half_pentagon_data, 3)
	
	var third_pentagon_data = FlavorData.new();
	third_pentagon_data.sweet = FlavorData.MAX_FLAVOR / 4
	third_pentagon_data.sour = FlavorData.MAX_FLAVOR / 4
	third_pentagon_data.salty = FlavorData.MAX_FLAVOR / 4
	third_pentagon_data.bitter = FlavorData.MAX_FLAVOR / 4
	third_pentagon_data.umami = FlavorData.MAX_FLAVOR / 4
	_generate_flavor_pentagon(third_pentagon_data, 1)
	
	
	var fourth_pentagon_data = FlavorData.new();
	fourth_pentagon_data.sweet = FlavorData.MAX_FLAVOR * 3 / 4
	fourth_pentagon_data.sour = FlavorData.MAX_FLAVOR * 3 / 4
	fourth_pentagon_data.salty = FlavorData.MAX_FLAVOR * 3 / 4
	fourth_pentagon_data.bitter = FlavorData.MAX_FLAVOR * 3 / 4
	fourth_pentagon_data.umami = FlavorData.MAX_FLAVOR * 3 / 4
	_generate_flavor_pentagon(fourth_pentagon_data, 1)
	
func generate_spice_report(flavor_data: FlavorData) -> void:
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
