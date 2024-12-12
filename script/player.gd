extends CharacterBody2D

class_name Player

signal stick_collected
signal apple_collected
signal slime_collected 

@onready var arrowShot = $arrow_shot
@onready var dead_player = $dead_player

var speed = 100
var health = 100
var health_max = 100
var health_min = 0
var dead = false

var player_state

@export var inv: Inv

func _ready():
	if not inv:
		inv = preload("res://script/inventory.gd").new()

var bow_equipped = false
var bow_cooldown = true
var arrow = preload("res://scenes/arrow.tscn")
var mouse_loc_from_player = null

@onready var camera = $Camera2D
@onready var healthBar = $HealthBar

func _physics_process(delta: float) -> void:
	if !dead: 
		mouse_loc_from_player = get_global_mouse_position() - self.position
	
		var direction = Input.get_vector("left","right","up","down")
		
		if direction.x == 0 and direction.y == 0:
			player_state = "idle"
		elif direction.x != 0 or direction.y != 0:
			player_state = "walking"
		
		velocity = direction * speed
		move_and_slide()
		
		if Input.is_action_just_pressed("e"):
			if bow_equipped:
				bow_equipped = false
			else: 
				bow_equipped = true
		
		var mouse_position = get_global_mouse_position()
		$Marker2D.look_at(mouse_position)
		
		if Input.is_action_just_pressed("left_mouse") and bow_equipped and bow_cooldown:
			arrowShot.play()
			bow_cooldown = false
			var arrow_instance = arrow.instantiate()
			arrow_instance.rotation = $Marker2D.rotation
			arrow_instance.global_position = $Marker2D.global_position
			add_child(arrow_instance)
			
			await get_tree().create_timer(0.4).timeout
			bow_cooldown = true
		
		play_animation(direction)
	
	else:
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(1).timeout
		$AnimatedSprite2D.visible=false
		healthBar.visible = false



func play_animation(dir):
	if !bow_equipped:
		speed = 100
		if player_state == "idle":
			$AnimatedSprite2D.play("idle")
		elif player_state == "walking":
			var north_south = ""
			if dir.y < -.5:
				north_south = "n"
			elif dir.y > .5:
				north_south = "s"
			
			var east_west = ""
			if dir.x > .5:
				east_west = "e"
			elif dir.x < -.5:
				east_west = "w"
			$AnimatedSprite2D.play(north_south + east_west + "-walk")
	else:
		speed = 0
		var is_x_in_bound = mouse_loc_from_player.x >= -25 and mouse_loc_from_player.x <= 25
		var is_y_in_bound = mouse_loc_from_player.y >= -25 and mouse_loc_from_player.y <= 25
		
		var north_south = ""
		if !is_y_in_bound:
			if mouse_loc_from_player.y < 0:
				north_south = "n"
			elif mouse_loc_from_player.y > 0:
				north_south = "s"
		
		var east_west = ""
		if !is_x_in_bound:
			if mouse_loc_from_player.x > 0:
				east_west = "e"
			elif mouse_loc_from_player.x < 0:
				east_west = "w"
		$AnimatedSprite2D.play(north_south + east_west + "-attack")
		
		
		
func player():
	pass

func collect(item): 
	inv.insert(item)
	print(item)
	if item.resource_path == ("res://inventory/items/stick.tres"): #stick
		emit_signal("stick_collected")
	if item.resource_path == ("res://inventory/items/slime.tres"):
		emit_signal("slime_collected")
	if str(item) == ("<Resource#-9223372003686218380>"): #apple
		emit_signal("apple_collected")


func _on_damage_detection_body_entered(body: Node2D) -> void:
	var damage
	if body.has_method("slime_check"):
		damage=10
		take_damage(damage)

func take_damage(damage):
	health = health-damage
	if health <= 0 and !dead:
		dead = true
		dead_player.play()
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/dead.tscn")
