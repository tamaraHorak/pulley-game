extends StaticBody2D

@export var dialogue: Array = [
	{"speaker": "NPC", "text": "Hello traveler!"},
	{"speaker": "Player", "text": "Hi! What do I need to do?"},
	{"speaker": "NPC", "text": "Bring the sac to the end!"},
	{"speaker": "Player", "text": "Got it, thanks!"},
]

var dialogue_index := 0
var player_ref = null


func _ready():
	print("=== NPC SCRIPT IS RUNNING ===")


func _on_area_2d_body_entered(body):
	print(">>> Something entered: ", body.name)

	if body.name == "Player":
		print(">>> It's the player!")

		player_ref = body
		body.current_npc = self

		dialogue_index = 0

		print(">>> Calling show_dialogue")
		player_ref.show_dialogue(dialogue[dialogue_index])
		print(">>> show_dialogue called")


func _on_area_2d_body_exited(body):
	if body.name == "Player":

		if player_ref != null:
			player_ref.hide_dialogue()

		body.current_npc = null
		player_ref = null
		dialogue_index = 0


func advance_dialogue():
	if player_ref == null:
		return
		
	dialogue_index += 1

	if dialogue_index < dialogue.size():
		player_ref.show_dialogue(dialogue[dialogue_index])

	else:
		player_ref.hide_dialogue()
		dialogue_index = 0
