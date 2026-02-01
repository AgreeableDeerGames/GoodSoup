extends Node

class_name FlavorData
var rng = RandomNumberGenerator.new()

static var MAX_FLAVOR = 10

@export_range(-10, 10, 0.1, "0 - 10")
var sweet: float = 0
@export_range(-10, 10, 0.1, "0 - 10")
var sour: float = 0
@export_range(-10, 10, 0.1, "0 - 10")
var salty: float = 0
@export_range(-10, 10, 0.1, "0 - 10")
var bitter: float = 0
@export_range(-10, 10, 0.1, "0 - 10")
var umami: float = 0
@export_range(-10, 10, 0.1, "0 - 10")
var numbing_spice: float = 0
@export_range(-10, 10, 0.1, "0 - 10")
var hot_spice: float = 0
@export_range(-10, 10, 0.1, "0 - 10")
var nasal_spice: float = 0
@export_range(-10, 10, 0.1, "0 - 10")
var richness: float = 0
@export_range(-10, 10, 0.1, "0 - 10")
var acidity: float = 0

func copy_from(other: FlavorData) -> void:
	sweet = other.sweet
	sour = other.sour
	salty = other.salty
	bitter = other.bitter
	umami = other.umami
	numbing_spice = other.numbing_spice
	hot_spice = other.hot_spice
	nasal_spice = other.nasal_spice
	richness = other.richness
	acidity = other.acidity

func _flavor_as_array() -> Array[float]:
	return [sweet, sour, salty, bitter, umami]
	
func _spice_as_array() -> Array[float]:
	return [numbing_spice, hot_spice, nasal_spice]
	
func _rich_acid_as_array() -> Array[float]:
	return [richness, acidity]
	
static func _array_equal_with_tolerance(
	first: Array[float], 
	second: Array[float], 
	tolerances: Array[float]) -> bool:
		if first.size() != second.size() || first.size() != tolerances.size():
			push_warning("")
			return false
		for i in range(0, first.size() - 1):
			if absf(first[i] - second[i]) > tolerances[i]:
				return false
		return true

func flavor_equal_with_tolerance(other: FlavorData, tolerances: FlavorData) -> bool:
	return _array_equal_with_tolerance(\
		self._flavor_as_array(), \
		other._flavor_as_array(), \
		tolerances._flavor_as_array())
	
func spice_equal_with_tolerance(other: FlavorData, tolerances: FlavorData) -> bool:
	return _array_equal_with_tolerance(\
		self._spice_as_array(), \
		other._spice_as_array(), \
		tolerances._spice_as_array())
	
func rich_acid_equal_with_tolerance(other: FlavorData, tolerances: FlavorData) -> bool:
	return _array_equal_with_tolerance(\
		self._rich_acid_as_array(), \
		other._rich_acid_as_array(), \
		tolerances._rich_acid_as_array())
		
func generate_values():
	sour = rng.randf_range(-10, 10)
	sweet = rng.randf_range(-10, 10)
	salty = rng.randf_range(-10, 10)
	bitter = rng.randf_range(-10, 10)
	umami = rng.randf_range(-10, 10)
	numbing_spice = rng.randf_range(-10, 10)
	hot_spice = rng.randf_range(-10, 10)
	nasal_spice = rng.randf_range(-10, 10)
