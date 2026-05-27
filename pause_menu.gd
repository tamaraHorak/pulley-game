extends CanvasLayer

@onready var anim = $AnimationPlayer

var is_transitioning = false


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()


func pause():
	var scene = get_tree().current_scene.scene_file_path
	if scene == "res://main_menu.tscn" or scene == "res://end_screen.tscn" or scene == "res://options.tscn":
		return
	if is_transitioning:
		return

	is_transitioning = true

	get_tree().paused = true

	show()
	anim.play("pause_in")

	await anim.animation_finished

	is_transitioning = false


func resume():
	if is_transitioning:
		return

	is_transitioning = true

	get_tree().paused = false

	anim.play("pause_out")

	await anim.animation_finished

	hide()
	is_transitioning = false


func force_hide():
	is_transitioning = false
	anim.stop()
	hide()


func _on_resume_pressed():
	resume()


func _on_options_pressed():
	get_tree().paused = false
	get_node("/root/UIManager").change_scene("res://options.tscn")


func _on_menu_pressed():
	get_tree().paused = false
	get_node("/root/UIManager").change_scene("res://main_menu.tscn")
