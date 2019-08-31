extends Node

var completed_dialog_keys = []
onready var mathias = $Mathias
onready var ladders = $Ladders.get_children()
onready var characters = $Characters.get_children()
onready var dialog = $Dialog

func _ready():
	dialog.connect("end_dialog", self, "_on_End_Dialog")
	dialog.connect("play_emote", self, "_on_Play_Emote")
	var found = dialog.get_dialogset(name, "START_GAME")
	if found:
		start_room_dialog()

func _on_Move_Ladder(current_ladder):
	var ladder_id = int(current_ladder.split("-")[1])
	
	if ladder_id % 2 == 0:
		ladder_id += 1
	else:
		ladder_id -= 1
	
	var next_ladder_name = "Ladder-" + str(ladder_id)
	var next_ladder = null
	for ladder in ladders:
		if ladder.name == next_ladder_name:
			next_ladder = ladder
			break
			
	prints(current_ladder, next_ladder_name)
	mathias.position = next_ladder.position + Vector2(0,-16)
	
	var found = dialog.get_dialogset(name, next_ladder_name)
	if found and !completed_dialog_keys.has(next_ladder_name):
		start_room_dialog()

func start_room_dialog():
	mathias.set_process(false)
	dialog.trigger_fxn()
	dialog.set_dialog_position(mathias.global_position)
	dialog.play_dialog()

func _on_End_Dialog(dialog_key):
	if dialog_key == "START_GAME":
		mathias.connect("move_ladder", self, "_on_Move_Ladder")
		mathias.connect("interact_to", self, "_on_Interact")
		mathias.set_process(true)
		completed_dialog_keys.append("START_GAME")
	elif "Ladder" in dialog_key and not "Elise" in dialog_key:
		mathias.set_process(true)
		completed_dialog_keys.append(dialog_key)

func play_dialog():
	dialog.play_dialog()

func _on_Play_Emote(character_list, emote_list):
	for i in range(character_list.size()):
		var details = character_list[i].split('|')
		if details[0] == "Mathias":
			mathias.play_emote(emote_list[i], true)
		else:
			match details[0]:
				"Characters": 
					for character in characters:
						if character.name == details[1]:
							character.play_emote(emote_list[i], true)
							break

func _on_Interact(key):
	print("here")
	var full_key = ""
	var is_repeat = false
	for dialog_key in completed_dialog_keys:
		var key_checker = full_key + key
		if key_checker == dialog_key:
			full_key = key_checker + "|REPEAT"
			is_repeat = true
			break
		full_key += dialog_key + "~"
	
	if not is_repeat:
		full_key += key
	print(full_key)
	var found = dialog.get_dialogset(name, full_key)
	if found:
		start_room_dialog()