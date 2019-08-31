extends ColorRect

var locations = [
	{
		"Id" : 1,
		"Name" : "Room-00",
		"DialogueSet": [
			{
				"Key": "START_GAME",
				"Dialogues": [
					"Mathias: How is that even possible that I am here all of the sudden.",
					"Mathias: I remembered that I was after a basketball game and take a nap for a while...",
					"Mathias: .....",
					"Mathias: What is that sounds? I can hear someone talking.",
					"Mathias: Hello! Who's there? Where am I?" 
				],
				"Emotes": [
					{ "Id" : 1, "Character_List": "Mathias", "Emote_List" : "undecided" },
					{ "Id" : 2, "Character_List": "Mathias", "Emote_List" : "mute" }
				],
				"Functions": {
					"Hide": [
						{ "Container": "Characters", "Name": "Elisa" },
						{ "Container": "Ladders", "Name": "Ladder-2" }
					],
					"Show": [
					]
				}
			},
			{
				"Key": "Ladder-1",
				"Dialogues": [
					"Mathias: I know I heard a vioce from here. A girl? Maybe Abby?",
					"Mathias: Abby was already in states for about a year now. Why I'm thinking of her this time?",
					"Mathias: .....",
					"Girl with a soft voice: Please come back here. I need your help.",
					"Mathias: Holy! Where are you? Come back to where?",
					"Mathias: Please let me know more! Damn!" 
				],
				"Emotes": [
					{ "Id" : 2, "Character_List": "Mathias", "Emote_List" : "mute" },
					{ "Id" : 3, "Character_List": "Mathias", "Emote_List" : "ghost" }
				],
				"Functions": {
					"Hide": [
						
					],
					"Show": [
					]
				}
			},
			{
				"Key": "Ladder-0",
				"Dialogues": [
					"Mathias: This is the only place to come back right? So...",
					"Girl with a soft voice: Thank you. I need your help.",
					"Mathias: Wait. Wait. Wait. You're asking for help even without telling me who you are?",
					"Elisa: I am Elisa. I wander here for a long time. It so nice to see someone. It's cold and dark here.",
					"Mathias: Oh! Hi Elisa. Before I help you, please tell me why I am here.",
					"Elisa: ....." 
				],
				"Emotes": [
					
				],
				"Functions": {
					"Hide": [
					],
					"Show": [
						{ "Container": "Characters", "Name": "Elisa" }
					]
				}
			},
			{
				"Key": "START_GAME~Ladder-1~Ladder-0~Elisa",
				"Dialogues": [
					"Mathias: So you're Elisa?",
					"Elisa: Yes.",
					"Both: .....",
					"Mathias: Hmmm! Okay! Hi Elisa! What do you mean by when you say you need my help?",
					"Elisa: I am here for a long time now.",
					"Mathias: What? How long? And where are we at the first place?",
					"Elisa: We are here in a old ruins of Gheltizka.", 
					"Elisa: My friend Paolo used to ask me here to check some of his drawings.",
					"Elisa: But after that blinding light, I did not see him anymore.",
					"Elisa: And also, I cannot find the exit in this ruins.",
					"Elisa: It seems strange that I don't feel anything even I didn't take any food or drinks.",
					"Mathias: WHAT! Are you sure you're not a ghost? You creeps me out.",
					"Elisa: Definitely! (grab his hand and put in her chest). Can you feel my heartbeat?",
					"Mathias: WAIT! NO! Ah YES! YES! (I don't know what to feel anymore)",
					"Mathias: Okay! Okay! Fine! I believe you now! (pull his hand)",
					"Elisa: If I remember correctly, Paolo said that there is a hidden passage here.",
					"Elisa: But in order to know that you must find all of the 4 artifacts.",
					"Mathias: What? Artifacts?",
					"Elisa: Yes, Artifacts! There are 4 artifact drawings that when combined will show the passage of light.",
					"Elisa: Here are the following artifacts that we must find.",
					"Elisa: 1st: Figures in Classical Ruins",
					"Elisa: 2nd: Ruins of a Basilica or Mausoleum",
					"Elisa: 3rd: Man Shading His Face with a Tricorne",
					"Elisa: 4th: One of Etching Collection",
					"Elisa: I know it is kinda hard to believe but maybe you can help me to find all of those?",
					"Mathias: Sure! if that's only our way to go out here. ",
					"Elisa: Great! Go back here when you find the items.",
					"Mathias: Hey! That's unfair! You should go with me.",
					"Elisa: I can't.. I tried but everytime I move out here I've just returned in this same spot.",
					"Mathias: Ok.... So, it is all by myself now. Fine! I'll go now Elisa.",
				],
				"Emotes": [
					{ "Id" : 1, "Character_List": "Mathias", "Emote_List" : "heart" },
					{ "Id" : 2, "Character_List": "Mathias,Characters|Elisa", "Emote_List" : "mute,mute" },
					{ "Id" : 4, "Character_List": "Mathias", "Emote_List" : "curious" },
				],
				"Functions": {
					"Hide": [
					],
					"Show": [
						{ "Container": "Ladders", "Name": "Ladder-2" }
					]
				}
			},
			{
				"Key": "START_GAME~Ladder-1~Ladder-0~Elisa|REPEAT",
				"Dialogues": [
					"Elisa: Here are the following artifacts that we must find.",
					"Elisa: 1st: Figures in Classical Ruins",
					"Elisa: 2nd: Ruins of a Basilica or Mausoleum",
					"Elisa: 3rd: Man Shading His Face with a Tricorne",
					"Elisa: 4th: One of Etching Collection"
				],
				"Emotes": [
				],
				"Functions": {
					"Hide": [
					],
					"Show": [
					]
				}
			},
			{
				"Key": "END_GAME",
				"Dialogues": [
					"You finally did it!"
				],
				"Functions": {
					"Hide": [
					],
					"Show": [
					]
				}
			}
		]
	}
]

onready var dialog_node = $Dialog

var current_dialog = []
var current_function_hide = []
var current_function_show = []
var current_emotes = []

var current_dialog_line = 0
var current_location_dialog_name
signal end_dialog
signal play_emote

func _ready():
	visible = false
	locations = JSON.parse(JSON.print(locations)).result
#	current_dialog = get_dialog("Room-00", "START_GAME")
#	play_dialog()
	pass # Replace with function body.

func _process(delta):
	
	if visible and current_dialog_line != current_dialog.size():
		var A = Input.is_action_just_pressed("a")
		if A and dialog_node.visible_characters < dialog_node.text.length() + 1:
			dialog_node.visible_characters = dialog_node.text.length() + 1
		elif A and dialog_node.visible_characters == dialog_node.text.length() + 1 and current_dialog_line != current_dialog.size() - 1:
			current_dialog_line += 1
			dialog_node.visible_characters = 0
			dialog_node.text = current_dialog[current_dialog_line]
			play_emote(current_dialog_line)
		elif A and dialog_node.visible_characters == dialog_node.text.length() + 1 and current_dialog_line == current_dialog.size() - 1:
			close_dialog()
		elif dialog_node.visible_characters < dialog_node.text.length() + 1:
			dialog_node.visible_characters += 1
		
	pass

func play_dialog():
	visible = true
	
	current_dialog_line = 0
	dialog_node.visible_characters = 0
	dialog_node.text = current_dialog[current_dialog_line]
	play_emote(current_dialog_line)
	$Skip/AnimBlink.play("default")
	
	set_process(true)
	pass

func close_dialog():
	visible = false
	set_process(false)
	emit_signal("end_dialog", current_location_dialog_name)
	pass

func play_emote(index):
	var character_list = []
	var emote_list = []
	for emote in current_emotes:
		if emote.Id == index:
			character_list = emote.Character_List.split(',')
			emote_list = emote.Emote_List.split(',')
			break
			
	if character_list.size() != 0:
		emit_signal("play_emote", character_list, emote_list)

func get_dialogset(location_name, location_dialog_name):
	var found = false
	for location in locations:
		if location.Name == location_name:
			for dialog_set in location.DialogueSet:
				if dialog_set.Key == location_dialog_name:
					current_location_dialog_name = location_dialog_name
					current_dialog = dialog_set.Dialogues
					current_function_hide = dialog_set.Functions.Hide
					current_function_show = dialog_set.Functions.Show
					current_emotes = dialog_set.Emotes
					found = true
					break
	return found

func set_dialog_position(player_global_pos):
	var x = floor(player_global_pos.x / 160) * 160
	var y = (floor(player_global_pos.y / 144) * 144) + 114
	rect_position = Vector2(x, y)

func trigger_fxn():
	for hide in current_function_hide:
		get_parent().get_node(hide.Container).get_node(hide.Name).deactivate()
	for show in current_function_show:
		get_parent().get_node(show.Container).get_node(show.Name).activate()