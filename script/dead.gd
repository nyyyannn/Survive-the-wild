extends Control

@onready var player_dead = $player_dead

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	AudioPlayer.stop_music_level()
	player_dead.play()


func _on_returntomainmenu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
