extends Node2D

func _ready():
	await get_tree().process_frame
	await UIManager.fade_in()

func _on_back_to_main_pressed():
	await UIManager.change_scene("res://main_menu.tscn")
