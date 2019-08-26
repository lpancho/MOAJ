extends Area2D
class_name Player

onready var ray = $RayCast2D
onready var anim = $AnimatedSprite

# movement
var speed = 64
var tile_size = 16
var movedir = Vector2()
var current_ladder = null
signal move_ladder

func _ready():
	set_process(false)
	pass

func _process(delta):
	if !ray.is_colliding():
		position += speed * movedir * delta
	
	var SPACE = Input.is_action_just_pressed("ui_accept")
	if SPACE:
		if current_ladder:
			emit_signal("move_ladder", current_ladder)
		
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

func _on_Mathias_area_entered(area):
	if area is Ladder:
		current_ladder = area
	pass # Replace with function body.

func _on_Mathias_area_exited(area):
	if area is Ladder:
		current_ladder = null
	pass # Replace with function body.
