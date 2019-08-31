extends KinematicBody2D
class_name Player

onready var ray = $RayCast2D
onready var anim = $AnimatedSprite
onready var emote = $Emote

# movement
var speed = 64
var tile_size = 16
var movedir = Vector2()
var interactable_object = null

var keys = []
var artifacts = []

# signals
signal move_ladder
signal interact_to
signal acquire_item

func _ready():
	set_process(false)
	pass

func _process(delta):
	if !ray.is_colliding():
		move_and_slide(speed * movedir)
	
	var SPACE = Input.is_action_just_pressed("ui_accept")
	if SPACE:
		if interactable_object:
			match interactable_object.group:
				"Ladder": emit_signal("move_ladder", interactable_object.name)
				"Characters": emit_signal("interact_to", interactable_object.name)
				"Keys": emit_signal("acquire_item", interactable_object, null)
				"Chests": emit_signal("acquire_item", interactable_object, keys)
		
	get_movedir()
	get_animation()

func get_movedir():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
	if movedir.x != 0 && movedir.y != 0:
		movedir = Vector2.ZERO
	
	if movedir != Vector2.ZERO:
		if movedir.y == 1:
			ray.cast_to = movedir * tile_size * 2
		else:
			ray.cast_to = movedir * tile_size

func get_animation():
	if movedir.x > 0:
		anim.play("walk_right")
	elif movedir.x < 0:
		anim.play("walk_left")
	elif movedir.y > 0:
		anim.play("walk_down")
	elif movedir.y < 0:
		anim.play("walk_up")
	else:
		var idle_anim = "idle_" + anim.animation.split("_")[1]
		anim.play(idle_anim)

func play_emote(name, is_once):
	emote.show_emote(name, is_once)