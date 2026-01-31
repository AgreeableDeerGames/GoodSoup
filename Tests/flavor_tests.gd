extends Node2D

var flavor_data = load("res://Scripts/flavor_data.gd")

func _make_flavor_data(value: float) -> FlavorData:
	var fd1 = FlavorData.new()
	fd1.sweet = value
	fd1.sour = value
	fd1.salty = value
	fd1.bitter = value
	fd1.umami = value
	fd1.hot_spice = value
	fd1.nasal_spice = value
	fd1.numbing_spice = value
	return fd1
	
func test1():
	var fd1: FlavorData = _make_flavor_data(10)
	var fd2: FlavorData = _make_flavor_data(10)
	var tol: FlavorData = _make_flavor_data(.5)
	var compare_flav: bool = fd1.flavor_equal_with_tolerance(fd2, tol)
	var compare_spice: bool = fd1.spice_equal_with_tolerance(fd2, tol)
	if !compare_flav || !compare_spice:
		print("flavor compare fail 1")
		
func test2():
	var fd1: FlavorData = _make_flavor_data(10)
	var fd2: FlavorData = _make_flavor_data(10.4)
	var tol: FlavorData = _make_flavor_data(.5)
	var compare_flav: bool = fd1.flavor_equal_with_tolerance(fd2, tol)
	var compare_spice: bool = fd1.spice_equal_with_tolerance(fd2, tol)
	if !compare_flav || !compare_spice:
		print("flavor compare fail 2")
		
func test3():
	var fd1: FlavorData = _make_flavor_data(10)
	var fd2: FlavorData = _make_flavor_data(10.6)
	var tol: FlavorData = _make_flavor_data(.5)
	var compare_flav: bool = fd1.flavor_equal_with_tolerance(fd2, tol)
	var compare_spice: bool = fd1.spice_equal_with_tolerance(fd2, tol)
	if compare_flav || compare_spice:
		print("flavor compare fail 3")

func test4():
	var fd1: FlavorData = _make_flavor_data(10)
	fd1.bitter = 10.8
	var fd2: FlavorData = _make_flavor_data(10.2)
	var tol: FlavorData = _make_flavor_data(.5)
	var compare_flav: bool = fd1.flavor_equal_with_tolerance(fd2, tol)
	var compare_spice: bool = fd1.spice_equal_with_tolerance(fd2, tol)
	if compare_flav || !compare_spice:
		print("flavor compare fail 4")
		
func test5():
	var fd1: FlavorData = _make_flavor_data(10)
	fd1.hot_spice = 10.8
	var fd2: FlavorData = _make_flavor_data(10.2)
	var tol: FlavorData = _make_flavor_data(.5)
	var compare_flav: bool = fd1.flavor_equal_with_tolerance(fd2, tol)
	var compare_spice: bool = fd1.spice_equal_with_tolerance(fd2, tol)
	if !compare_flav || compare_spice:
		print("flavor compare fail 5")
		
func test6():
	var fd1: FlavorData = _make_flavor_data(10)
	fd1.hot_spice = 10.7
	var fd2: FlavorData = _make_flavor_data(10.2)
	var tol: FlavorData = _make_flavor_data(.1)
	var compare_flav: bool = fd1.flavor_equal_with_tolerance(fd2, tol)
	var compare_spice: bool = fd1.spice_equal_with_tolerance(fd2, tol)
	if compare_flav || compare_spice:
		print("flavor compare fail 6")
		
func test7():
	var fd1: FlavorData = _make_flavor_data(10)
	fd1.hot_spice = 10.7
	var fd2: FlavorData = _make_flavor_data(10.01)
	var tol: FlavorData = _make_flavor_data(.1)
	var compare_flav: bool = fd1.flavor_equal_with_tolerance(fd2, tol)
	var compare_spice: bool = fd1.spice_equal_with_tolerance(fd2, tol)
	if !compare_flav || !compare_spice:
		print("flavor compare fail 7")
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	test1()
	test2()
	test3()
	test4()
	test5()
	test6()
	test6()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
