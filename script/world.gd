extends Node2D

func _on_transition_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_file("res://scenes/world_3.tscn")
