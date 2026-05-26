extends Control

@onready var congratulations_label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CongratulationsLabel
@onready var time_label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/TimeLabel

func _ready():
	GameManager.stop_timer()
	time_label.text = "Your Time:\n" + GameManager.get_time_string()
	print(GameManager.get_time_string())
	await get_tree().process_frame  
	await UIManager.fade_in()

func _on_menu_pressed():
	GameManager.reset_timer()
	get_tree().change_scene_to_file("res://main_menu.tscn")
