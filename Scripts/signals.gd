extends Node

# From a path, create a new scene with a transition.
# resetTree - true, deletes all other scenes on tree - usefult for switching to main menu, etc
# init_fn - if provided with call a specified lambda on the newly instatiated scene
@warning_ignore("unused_signal")
signal load_new_scene(scene_name : String, resetTree : bool, init_fn : Variant)

# Move back up the scene tree. The last shown scene will be displayed. If the tree would be clean, this does nnothing.
@warning_ignore("unused_signal")
signal back_to_previous_scene()
