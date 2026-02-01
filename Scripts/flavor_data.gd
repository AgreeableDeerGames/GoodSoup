extends Node

class_name FlavorData

static var MAX_FLAVOR = 10

@export_range(0, 10, 0.1, "0 - 10")
var sweet: float = 0
@export_range(0, 10, 0.1, "0 - 10")
var sour: float = 0
@export_range(0, 10, 0.1, "0 - 10")
var salty: float = 0
@export_range(0, 10, 0.1, "0 - 10")
var bitter: float = 0
@export_range(0, 10, 0.1, "0 - 10")
var umami: float = 0
@export_range(0, 10, 0.1, "0 - 10")
var numbing_spice: float = 0
@export_range(0, 10, 0.1, "0 - 10")
var hot_spice: float = 0
@export_range(0, 10, 0.1, "0 - 10")
var nasal_spice: float = 0
@export_range(0, 10, 0.1, "0 - 10")
var richness: float = 0
@export_range(0, 10, 0.1, "0 - 10")
var acidity: float = 0

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
		
	
