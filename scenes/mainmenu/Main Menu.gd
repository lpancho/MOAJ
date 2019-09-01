extends Control

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
		    get_tree().quit()
		elif event.pressed and event.scancode == KEY_SPACE:
			get_tree().change_scene("res://scenes/rooms/Room-00.tscn")
