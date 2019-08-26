extends Node

var completed_dialog_keys = []
onready var mathias = $Mathias
onready var ladders = $Ladders.get_children()
onready var dialog = $Dialog

func _ready():
	dialog.connect("end_dialog", self, "_on_End_Dialog")
	var found = dialog.get_dialogset(name, "START_GAME")
	if found:
		dialog.play_dialog()

func _on_Move_Ladder(current_ladder):
	var ladder_id = int(current_ladder.name.split("-")[1])
	
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
	mathias.position = next_ladder.position
	
	var found = dialog.get_dialogset(name, next_ladder_name)
	if found and !completed_dialog_keys.has(next_ladder_name):
		mathias.set_process(false)
		dialog.trigger_fxn()
		dialog.set_dialog_position(mathias.global_position)
		dialog.play_dialog()

func _on_End_Dialog(dialog_key):
	if dialog_key == "START_GAME":
		mathias.connect("move_ladder", self, "_on_Move_Ladder")
#		mathias.connect("interact", self, "_on_Interact")
		mathias.set_process(true)
		completed_dialog_keys.append("START_GAME")
	elif "Ladder" in dialog_key:
		mathias.set_process(true)
		completed_dialog_keys.append("Ladder-1")

func set_dialog(key):
	dialog.current_dialog = dialog.get_dialog(get_parent().name, "START_GAME")

func play_dialog():
	dialog.play_dialog()

func _on_Interact(key):
	set_dialog(key)
	