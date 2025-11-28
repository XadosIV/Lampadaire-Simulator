extends AudioStreamPlayer

const level_music = preload("res://Horror-Ambiance-_Royalty-Free_.wav")
@export var sound: AudioStreamPlayer

func _play_music(music: AudioStream, volume = -10.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_level_music():
	_play_music(level_music)
