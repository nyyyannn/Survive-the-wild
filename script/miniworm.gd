extends CharacterBody2D

func _on_hitbox_body_entered(body: Node2D) -> void:
	body.take_damage(10)
