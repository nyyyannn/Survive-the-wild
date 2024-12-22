extends Control

@onready var win=$win

func _ready() -> void:
	$celebrations.play("default")
	AudioPlayer.stop_music_level()
	win.play()

func _on_returntomainmenu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
