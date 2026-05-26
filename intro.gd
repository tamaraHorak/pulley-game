extends Node2D

func _ready():
	# Empêche le joueur de bouger pendant l'intro
	$Player.set_physics_process(false)
	$Player.set_process(false)
	
	# Lance le premier dialogue automatiquement
	var npc = $npc_instructor
	npc.player_ref = $Player
	$Player.current_npc = npc
	$Player.show_dialogue(npc.dialogue[0])
	npc.dialogue_index = 0
	await get_tree().process_frame  
	await UIManager.fade_in()

func _process(_delta):
	# Skip tout le dialogue avec TAB
	if Input.is_action_just_pressed("skip"):
		get_tree().change_scene_to_file("res://Back_1.tscn")
		GameManager.start_timer()
		return
	
	# Avance dans le dialogue avec Espace
	if Input.is_action_just_pressed("interact"):
		var npc = $npc_instructor
		npc.dialogue_index += 1
		if npc.dialogue_index < npc.dialogue.size():
			$Player.show_dialogue(npc.dialogue[npc.dialogue_index])
		else:
			get_tree().change_scene_to_file("res://Back_1.tscn")
			GameManager.start_timer()
