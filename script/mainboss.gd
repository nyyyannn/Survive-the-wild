extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

var dead = false
var health = 200
var health_max = 200
var health_min = 0

func _ready() -> void:
	await get_tree().create_timer(10).timeout

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("idle")

func _on_playerdetection_body_entered(body: Node2D) -> void:
	animation_player.play("attack")

func _on_hitbox_body_entered(body: Node2D) -> void:
	body.take_damage(20)
 # Replace with function body.

func _on_damagedealer_area_entered(area: Area2D) -> void:
	var damage
	if area.has_method("arrow_deal_damage"):
		damage = 10
		take_damage(damage)

func take_damage(damage):
	health = health-damage
	if health <= 0 and !dead:
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/ending.tscn")
		
