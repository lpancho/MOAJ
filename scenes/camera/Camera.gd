extends Camera2D

func _process(delta):
	var pos = get_node("../Mathias").global_position
	var x = floor(pos.x / 160) * 160
	var y = floor(pos.y / 144) * 144
	global_position = Vector2(x, y)
	pass # Replace with function body.
