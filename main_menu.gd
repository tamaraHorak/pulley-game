extends Node2D

@onready var anim = $Fade/Fade_transition/AnimationPlayer
@onready var fade_node = $Fade/Fade_transition
@onready var fade_timer = $Fade/Fade_transition/fade_timer

var button_type = null

func _ready():
	anim.play("fade_out")
	await anim.animation_finished  
	fade_node.hide()  

func _on_start_pressed():
	button_type = "start"
	fade_node.show() 
	fade_timer.start()
	anim.play("fade_in")
	


func _on_options_pressed():
	button_type = "options"
	fade_node.show() 
	fade_timer.start()
	anim.play("fade_in")
	


func _on_quit_pressed():
	get_tree().quit()
 


func _on_fade_timer_timeout():
	if button_type == "start" : 
		get_tree().change_scene_to_file("res://Back_1.tscn")
	elif button_type == "options" :
		get_tree().change_scene_to_file("res://options.tscn")
