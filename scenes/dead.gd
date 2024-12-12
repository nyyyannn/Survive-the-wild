extends Control

@onready var player_dead = $player_dead

func _ready() -> void:
	player_dead.play()
