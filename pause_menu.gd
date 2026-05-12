extends Control

@onready var optionsMenu = preload("res://options.tscn")
@onready var anim = $Fade/Fade_transition/AnimationPlayer
@onready var fade_node = $Fade/Fade_transition
@onready var fade_timer = $Fade/Fade_transition/fade_timer

var button_type = null

func _ready():
	if Engine.is_editor_hint():
		return
	hide()
	anim.play("fade_out")
	if anim.is_playing():
		await anim.animation_finished
	fade_node.hide() 
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
 
func _process(_delta):
	testEsc()

func _on_options_pressed():
	button_type = "options"
	fade_node.show()
	anim.play("fade_in")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://options.tscn")

func _on_menu_pressed():
	button_type = "menu"
	fade_node.show()
	anim.play("fade_in")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
