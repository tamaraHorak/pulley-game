extends Node

var fade
var pause_menu

func setup(root: Node):
	fade = preload("res://fade_transition.tscn").instantiate()
	pause_menu = preload("res://pause_menu.tscn").instantiate()

	root.add_child(fade)
	root.add_child(pause_menu)

	fade.hide()
	pause_menu.hide()
	
func fade_in():
	fade.show()
	fade.get_node("AnimationPlayer").play("fade_in")

func fade_out() -> void:
	fade.show()
	fade.get_node("AnimationPlayer").play("fade_out")
	await fade.get_node("AnimationPlayer").animation_finished
	
func toggle_pause():
	if pause_menu.visible:
		pause_menu.hide()
		get_tree().paused = false
	else:
		pause_menu.show()
		get_tree().paused = true
