extends Node2D

@onready var anim = $Fade/Fade_transition/AnimationPlayer
@onready var fade_node = $Fade/Fade_transition
@onready var fade_timer = $Fade/Fade_transition/fade_timer

func _ready():
	UIManager.setup(self)
	anim.play("fade_out")
	await anim.animation_finished
	fade_node.hide()
	
