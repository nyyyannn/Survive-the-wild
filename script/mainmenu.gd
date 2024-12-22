extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioPlayer.play_music_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
