extends Node2D


func _ready():
	await get_tree().process_frame
	await get_tree().process_frame
	await UIManager.fade_in()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://intro.tscn")

func _on_options_pressed():
	await UIManager.change_scene("res://options.tscn")

func _on_quit_pressed():
	get_tree().quit()
