extends KinematicBody2D

onready var emote = $Emote
onready var scope = $Scope

func _ready():
	pass

func deactivate():
	visible = false
	$Collision.disabled = true

func activate():
	visible = true
	$Collision.disabled = false

func play_emote(name, is_once):
	emote.show_emote(name, is_once)

func hide_emote():
	emote.hide_emote()

func _on_Scope_body_entered(body):
	if body.name == "Mathias":
		body.interactable_object = {"group": "Characters", "name" : name}
#		play_emote("talk", false)
	pass # Replace with function body.

func _on_Scope_body_exited(body):
	if body.name == "Mathias":
		body.interactable_object = null
#		hide_emote()
	pass # Replace with function body.
