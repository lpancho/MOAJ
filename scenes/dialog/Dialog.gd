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
				"Functions": {
					"Hide": [
						
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
				"Functions": {
					"Hide": [
						{ "Type": "Ladder", "Name": "Ladder-2" }
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
					"Elise: ....." 
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

var current_dialog_line = 0
var current_location_dialog_name
signal end_dialog

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
	$Skip/AnimBlink.play("default")
	set_process(true)
	pass

func close_dialog():
	visible = false
	set_process(false)
	emit_signal("end_dialog", current_location_dialog_name)
	pass

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
					found = true
	return found

func set_dialog_position(player_global_pos):
	var x = floor(player_global_pos.x / 160) * 160
	var y = (floor(player_global_pos.y / 144) * 144) + 114
	rect_position = Vector2(x, y)

func trigger_fxn():
	for hide in current_function_hide:
		if hide.Type == "Ladder":
			get_parent().get_node("Ladders").get_node(hide.Name).deactivate()
	for hide in current_function_show:
		if hide.Type == "Ladder":
			get_parent().get_node("Ladders").get_node(hide.Name).activate()