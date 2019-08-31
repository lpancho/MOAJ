extends Area2D

export var key = ""
export(Color) var color

onready var anim = $Anim
#onready var audio = $AudioStreamPlayer2D

signal acquire_key

func _ready():
	modulate = color

func get_key():
	anim.play("default")
	
func _on_Anim_animation_finished(anim_name):
	if anim_name == "default":
		emit_signal("acquire_key", key)
		visible = false
	pass # Replace with function body.

func _on_Key_body_entered(body):
	if body is Player:
		body.interactable_object = {"group": "Keys", "name": key }
	pass # Replace with function body.

func _on_Key_body_exited(body):
	if body is Player:
		body.interactable_object = null
	pass # Replace with function body.
