extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		print("Congrats")
		get_tree().change_scene_to_file("res://level_1.tscn")  
