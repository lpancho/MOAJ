extends Sprite

export var chest_key = ""
export(Rect2) var region_details

onready var sprite = $Sprite
onready var anim = $Anim
onready var audio = $AudioStreamPlayer2D

signal acquire_artifact

func _ready():
	sprite.set_region_rect(region_details)

func interact(keys):
	for key in keys:
		if chest_key == key:
			anim.play("default")

func _on_Anim_animation_finished(anim_name):
	if anim_name == "default":
		emit_signal("acquire_artifact", chest_key)
	pass # Replace with function body.
