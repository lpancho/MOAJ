extends Area2D
class_name Ladder

func deactivate():
	visible = false
	$Collision.disabled = true

func activate():
	visible = true
	$Collision.disabled = false