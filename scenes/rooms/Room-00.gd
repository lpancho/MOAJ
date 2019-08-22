extends Node2D

onready var mathias = $Mathias
onready var ladders = $Ladders.get_children()

var ladder_details = [
	[0, Vector2(120, 104)],
	[1, Vector2(304, 104)],
	[2, Vector2(208, 80)],
	[3, Vector2(112, 32)]
]

func _ready():
	mathias.connect("move_ladder", self, "_on_Move_Ladder")

func _on_Move_Ladder(current_ladder):
	print(current_ladder.name)
	var ladder_id = int(current_ladder.name.split("-")[1])
	
	if ladder_id % 2 == 0:
		ladder_id += 1
	else:
		ladder_id -= 1
	
	mathias.position = ladder_details[ladder_id][1]
