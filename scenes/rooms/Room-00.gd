extends Node

var completed_dialog_keys = []
onready var mathias = $Mathias
onready var ladders = $Ladders.get_children()
onready var characters = $Characters.get_children()
onready var keys = $Keys.get_children()
onready var chests = $Chests.get_children()
onready var artifacts = $Artifacts.get_children()
onready var timelapse = $Timelapse
onready var dialog = $Dialog

func _ready():
	mathias.visible = false
	dialog.connect("end_dialog", self, "_on_End_Dialog")
	dialog.connect("play_emote", self, "_on_Play_Emote")
	
	for key in keys:
		key.connect("acquire_key", self, "_on_Acquire_Key")
	
	for chest in chests:
		chest.connect("acquire_artifact", self, "_on_Acquire_Artifact")
	
	for artifact in artifacts:
		artifact.connect("artifact_dialog", self, "_on_Artifact_Dialog")
	
	timelapse.visible = true
	timelapse.play("distorted")

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
	mathias.set_process(true)
	prints("_on_End_Dialog", dialog_key)
	if dialog_key == "START_GAME":
		mathias.connect("move_ladder", self, "_on_Move_Ladder")
		mathias.connect("interact_to", self, "_on_Interact")
		mathias.connect("acquire_item", self, "_on_Acquire_Item")
		completed_dialog_keys.append("START_GAME")
	elif dialog_key == "START_GAME~Ladder-1~Ladder-0~Elisa|REPEAT|4":
		mathias.visible = false
		for character in characters:
			character.visible = false
			
		timelapse.visible = true
		timelapse.play("normal")
	elif "Ladder" in dialog_key:
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
			full_key = key_checker + "|REPEAT|" + str(mathias.keys.size())
			is_repeat = true
			break
		full_key += dialog_key + "~"
	
	if not is_repeat:
		full_key += key
	print(full_key)
	var found = dialog.get_dialogset(name, full_key)
	if found:
		start_room_dialog()

func _on_Acquire_Item(first_item, second_item):
	match first_item.group:
		"Keys":
			for key in keys:
				if first_item.name == key.key:
					key.get_key()
		"Chests":
			var found = false
			for chest in chests:
				if first_item.name == chest.chest_key and second_item.has(first_item.name):
					chest.interact(first_item.name)
					found = true
			if not found:
				print("You don't have the key")
	pass

func _on_Acquire_Key(key):
	mathias.keys.append(key)
	pass

func _on_Acquire_Artifact(artifact_key):
	var found = false
	for artifact in artifacts:
		if artifact.artifact_key == artifact_key:
			mathias.set_process(false)
			artifact.show_artifact()
			mathias.artifacts.append(artifact_key)
			found = true
	if found:
		prints("FOUND", artifact_key)
	pass

func _on_Artifact_Dialog(key):
	var found = dialog.get_dialogset(name, key)
	if found:
		start_room_dialog()
	pass

func _on_Timelapse_animation_finished():
	timelapse.visible = false
	if timelapse.animation == "distorted":
		mathias.visible = true
		var found = dialog.get_dialogset(name, "START_GAME")
		if found:
			start_room_dialog()
	elif timelapse.animation == "normal":
		get_tree().change_scene("res://scenes/credits/Credits.tscn")
		pass
		
	pass # Replace with function body.
