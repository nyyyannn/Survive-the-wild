extends Control

signal quest_menu_closed

@onready var transition = $transition
@onready var color_rect = $transition/ColorRect
 
var quest1_active = false
var quest1_completed = false
var slime = 0

func _ready():
	color_rect.visible=false

func _process(delta):
	if quest1_active:
		if slime == 1:
			print("quest 1 completed")
			quest1_active = false
			quest1_completed = true
			play_finish_quest_anim()
	#if quest2_active:

func quest1_chat():
	$quest1_ui.visible = true

func next_quest():
	if !quest1_completed:
		quest1_chat()
	else:
		$no_quest.visible = true
		await get_tree().create_timer(3).timeout
		$no_quest.visible = false
	#quest 2 checking:

func _on_yesbutton_1_pressed() -> void:
	$quest1_ui.visible = false
	quest1_active = true
	slime = 0
	emit_signal("quest_menu_closed")

func _on_nobutton_1_pressed() -> void:
	$quest1_ui.visible = false
	quest1_active = false
	emit_signal("quest_menu_closed")

func slime_collected():
	slime = slime + 1

func play_finish_quest_anim():
	$finished_quest.visible = true
	await get_tree().create_timer(3).timeout
	$finished_quest2.visible = true
	await get_tree().create_timer(1).timeout
	$finished_quest3.visible = true
	await get_tree().create_timer(1).timeout
	transition.play("fade_out")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/boss_fight.tscn")

 
