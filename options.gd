extends Node2D

@onready var anim = $Fade/Fade_transition/AnimationPlayer
@onready var fade_node = $Fade/Fade_transition
@onready var fade_timer = $Fade/Fade_transition/fade_timer

var button_type = null

func _ready():
	anim.play("fade_out")
	await anim.animation_finished  
	fade_node.hide()               

func _on_back_to_main_pressed():
	button_type = "back"
	fade_node.show()
	fade_timer.start()
	anim.play("fade_in")

func _on_fade_timer_timeout():
	if button_type == "back": 
		get_tree().change_scene_to_file("res://main_menu.tscn")
