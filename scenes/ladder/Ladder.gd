extends Area2D
class_name Ladder

func deactivate():
	visible = false
	$Collision.disabled = true

func activate():
	visible = true
	$Collision.disabled = false

func _on_Ladder_body_entered(body):
	if body is Player:
		body.interactable_object = {"group": "Ladder", "name": name }
	pass # Replace with function body.

func _on_Ladder_body_exited(body):
	if body is Player:
		body.interactable_object = null
	pass # Replace with function body.
