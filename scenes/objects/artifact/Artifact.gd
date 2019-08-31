extends Control

export var artifact_name = ""
onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.

func show_artifact():
	visible = true 
	anim.play("default")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "default":
		visible = false
	pass # Replace with function body.
