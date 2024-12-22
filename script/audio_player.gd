extends AudioStreamPlayer2D

const level_music = preload("res://audio/pixel-song-18-72641.mp3")

func _play_music(music: AudioStream, volume = -0.5):
	if stream == music:
		return
	
	stream = music
	volume_db=volume
	play()

func play_music_level():
	_play_music(level_music)

func _stop_music(music:AudioStream):
	stop()

func stop_music_level():
	_stop_music(level_music)
