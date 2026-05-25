extends Area2D

@export var next := "res://Back_4.tscn"
@onready var open_snd: AudioStreamPlayer = $Open

var triggered := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if triggered:
		return
	if body.name == "Player":
		triggered = true
		body.set_process(false)
		body.set_physics_process(false)
		open_snd.play()
		UIManager.change_scene(next)
