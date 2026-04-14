extends Area2D

var player_nearby = false
var player_ref = null

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D:
		player_nearby = true
		player_ref = body

func _on_body_exited(body):
	if body is CharacterBody2D:
		player_nearby = false
		player_ref = null

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("ui_accept"):
		player_ref.pick_up_sac()
		queue_free()
