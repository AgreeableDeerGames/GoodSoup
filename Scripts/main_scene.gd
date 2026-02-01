extends Node2D

var loop: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loop = load("res://Assets/SoupLoop_final.wav")
	
	var music: AudioStreamPlayer = $AudioStreamPlayer
	music.stream = load("res://Assets/SoupIntro_final.wav")
	music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_audio_stream_player_finished() -> void:
	var music: AudioStreamPlayer = $AudioStreamPlayer
	music.stream = loop
	music.play()
	
