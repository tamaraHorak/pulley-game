extends Node

var fade
var fade_anim
var pause_menu

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("setup")


func setup():
	if fade != null:
		return

	fade = preload("res://fade.tscn").instantiate()
	get_tree().root.add_child(fade)
	fade_anim = fade.get_node("Fade_transition/Anim")
	fade.hide()

	pause_menu = preload("res://pause_menu.tscn").instantiate()
	get_tree().root.add_child(pause_menu)


func _unhandled_input(event: InputEvent):
	if pause_menu == null:
		return
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			pause_menu.resume()
		else:
			pause_menu.pause()


func fade_out() -> void:
	fade.show()
	fade_anim.play("fade_in")
	await fade_anim.animation_finished


func fade_in() -> void:
	fade.show()
	fade_anim.play("fade_out")
	await fade_anim.animation_finished
	fade.hide()


func change_scene(path: String) -> void:
	await fade_out()

	get_tree().paused = false
	if pause_menu != null:
		pause_menu.force_hide()

	get_tree().change_scene_to_file(path)

	await get_tree().process_frame
	await fade_in()
