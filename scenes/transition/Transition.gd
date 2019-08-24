extends ColorRect

onready var anim = $Anim
signal show_scene

func _ready():
	anim.connect("animation_finished", self, "_on_Animation_finished")

func start_enter_scene():
	anim.play("start_enter_scene")

func end_enter_scene():
	anim.play("start_enter_scene")

func _on_Animation_finished(anim_name):
	if anim_name == "start_enter_scene":
		emit_signal("show_scene")