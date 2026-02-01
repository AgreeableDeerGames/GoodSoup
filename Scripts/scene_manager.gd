extends Node

@onready var transition_scene: Node2D = $TransitionScene
@onready var scenes: Node = $Scenes
const main_scene = preload("res://Scenes/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# load the main menu scene
	Signals.back_to_previous_scene.connect(_on_back_to_previous_scene)
	Signals.load_new_scene.connect(_on_load_new_scene)
	var scene = main_scene.instantiate()
	scenes.add_child(scene)
	transition_scene.get_node("AnimationPlayer").play("fade_to_clear")
	await transition_scene.get_node("AnimationPlayer").animation_finished

func _free_scene(node: Node):		
	for child_node in node.get_children():
		_free_scene(child_node)
	
	if node != scenes:
		node.queue_free()
	return

# You can uncomment this for testing
#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#Signals.emit_signal("load_new_scene", "res://Scenes/test_scene.tscn", false)
	#elif Input.is_action_just_pressed("ui_up"):
		#Signals.emit_signal("load_new_scene", "res://Scenes/test_scene.tscn", true)
	#elif Input.is_action_just_pressed("ui_down"):
		#Signals.emit_signal("back_to_previous_scene")
		
func _on_back_to_previous_scene() -> void:
	transition_scene.get_node("AnimationPlayer").play("fade_to_black")
	await transition_scene.get_node("AnimationPlayer").animation_finished
	
	if scenes.get_child_count() <= 1:
		print("cannot go back")
		return
		
	# Delete scene
	var scene_to_remove = scenes.get_child(-1)
	_free_scene(scene_to_remove)
	scenes.remove_child(scene_to_remove)
	
	scenes.get_child(-1).visible = true
	transition_scene.get_node("AnimationPlayer").play("fade_to_clear")
	await transition_scene.get_node("AnimationPlayer").animation_finished


func _on_load_new_scene(scene_name: String, resetTree: bool, init_fn : Variant = null) -> void:
	transition_scene.get_node("AnimationPlayer").play("fade_to_black")
	await transition_scene.get_node("AnimationPlayer").animation_finished
	
	if resetTree and scenes.get_child_count() != 0:
		# Remove the last main scene added by deleting
		_free_scene(scenes)
	
	if scenes.get_child_count() != 0:
		scenes.get_child(-1).visible = false
		
	var scene = load(scene_name).instantiate()

	# only allow lambdas or callables, then call it on the newly created scene
	if typeof(init_fn) == TYPE_CALLABLE:
		init_fn.call(scene)
	
	scenes.add_child(scene)
	transition_scene.get_node("AnimationPlayer").play("fade_to_clear")
	await transition_scene.get_node("AnimationPlayer").animation_finished
