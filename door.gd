extends Area2D

@export var next := "res://Back_4.tscn"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		print("Congrats")
		get_tree().change_scene_to_file(next)  
