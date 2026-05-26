extends Node2D

func _ready():
	await get_tree().process_frame  
	await UIManager.fade_in()
