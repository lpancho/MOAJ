extends StaticBody2D

export var chest_key = ""
export(Rect2) var region_details

onready var sprite = $Sprite
onready var anim = $Anim
#onready var audio = $AudioStreamPlayer2D

signal acquire_artifact
var retrieved = false

func _ready():
	sprite.set_region_rect(region_details)

func interact(key):
	if chest_key == key:
		anim.play("default")

func _on_Anim_animation_finished(anim_name):
	if anim_name == "default":
		retrieved = true
		emit_signal("acquire_artifact", chest_key)
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body is Player and not retrieved:
		body.interactable_object = {"group": "Chests", "name": chest_key }
	pass # Replace with function body.

func _on_Area2D_body_exited(body):
	if body is Player and not retrieved:
		body.interactable_object = null
	pass # Replace with function body.
