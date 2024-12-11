extends CharacterBody2D

const SPEED = 30
var current_state = IDLE 

var dir = Vector2.RIGHT
var start_pos

var is_roaming = false
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
	if Input.is_action_just_pressed(","):
		$Dialogue2.start()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")
	if Input.is_action_just_pressed("quest"):
		$npc_quest2.next_quest()
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

func _on_dialogue_2_dialogue_finished() -> void:
	is_chatting = false	
	is_roaming = true

func _on_npc_quest_2_quest_menu_closed() -> void:
	is_chatting = false
	is_roaming = false

func _on_player_slime_collected() -> void:
	$npc_quest2.slime_collected()
# Replace with function body.
