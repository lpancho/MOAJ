extends Control

export var artifact_name = "WHITE"
onready var sprite = $MarginContainer/Sprite
onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_artifact():
	match artifact_name:
		"WHITE":
			visible = true 
			anim.play("default")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "default":
		visible = false
	pass # Replace with function body.
