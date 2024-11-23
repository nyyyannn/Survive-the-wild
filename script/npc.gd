extends CharacterBody2D

const SPEED = 30
var current_state = IDLE 

var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

var player 
var player_in_chat_zone = false

enum{
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
	
func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_west")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk_east")
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_north")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_south")
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT,Vector2.UP,Vector2.LEFT,Vector2.DOWN])
			MOVE:
				move(delta)
	if Input.is_action_just_pressed(","):
		$Dialogue.start()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")
	if Input.is_action_just_pressed("quest"):
		$npc_quest.next_quest()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		position += dir * SPEED * delta

func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true

func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5,1,1.5])
	current_state = choose([IDLE,NEW_DIR,MOVE])

func _on_dialogue_dialogue_finished() -> void:
	is_chatting = false
	is_roaming = true

func _on_npc_quest_quest_menu_closed() -> void:
		is_chatting = false
		is_roaming = false

func _on_player_stick_collected() -> void:
	$npc_quest.stick_collected()
