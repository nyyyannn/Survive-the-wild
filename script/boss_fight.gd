extends Node2D

@onready var transition = $transition
@onready var color_rect = $transition/ColorRect

func _ready() -> void:
	color_rect.visible=false
	transition.play("fade_in")
	await get_tree().create_timer(3).timeout
	transition.queue_free()
