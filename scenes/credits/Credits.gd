extends Control

onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
		    get_tree().quit()
		elif event.pressed and event.scancode == KEY_SPACE:
			get_tree().change_scene("res://scenes/mainmenu/Main Menu.tscn")