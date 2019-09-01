extends Control

export var artifact_key = ""
export var artifact_name = ""
export(Texture) var artifact_texture
onready var anim = $AnimationPlayer
onready var sprite = $MarginContainer/Sprite
onready var label = $Label

signal artifact_dialog

func _ready():
	visible = false
	sprite.texture = artifact_texture
	label.text = artifact_name
	pass # Replace with function body.

func show_artifact():
	visible = true 
	anim.play("default")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "default":
		visible = false
		emit_signal("artifact_dialog", artifact_key)
	pass # Replace with function body.
