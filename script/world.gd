extends Node2D

@onready var transition = $transition

func _on_transition_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		transition.play("fade_out")

func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/world_3.tscn")
	
