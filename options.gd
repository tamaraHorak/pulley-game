extends Node2D


func _ready():
	$Fade_transition/AnimationPlayer.play("fade_out")
