extends Node3D


func _ready() -> void:
	AudioPlayer.play_level_music()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
