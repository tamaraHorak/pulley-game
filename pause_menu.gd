extends Control

@onready var optionsMenu = preload("res://options.tscn")
@onready var anim = $Fade/Fade_transition/AnimationPlayer
@onready var fade_node = $Fade/Fade_transition
@onready var fade_timer = $Fade/Fade_transition/fade_timer

func _ready():
	hide()
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	show()
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()


func _on_resume_pressed():
	resume()
 

func _process(delta):
	testEsc()


func _on_options_pressed():
	resume()
	get_tree().change_scene_to_file("res://options.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
