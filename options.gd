extends Node2D


func _ready():
	$Fade_transition/AnimationPlayer.play("fade_out")


func _on_back_to_main_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
