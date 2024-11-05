extends CharacterBody2D

var speed = 100

var player_state

@export var inv: Inv

var bow_equipped = false
var bow_cooldown = true
var arrow = preload("res://scenes/arrow.tscn")
var mouse_loc_from_player = null

func _physics_process(delta: float) -> void:
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
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.4).timeout
		bow_cooldown = true
	
	play_animation(direction)

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
