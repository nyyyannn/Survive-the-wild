extends Node2D

@onready var transition = $transition

func _ready() -> void:
	transition.play("fade_in")
	await get_tree().create_timer(3).timeout
	transition.queue_free()
