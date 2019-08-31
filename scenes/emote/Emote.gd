extends Sprite

var emotes = [
	{ "Name": "exclamation", "Texture": "res://assets/emotes/pipo-popupemotes001.png" },
	{ "Name": "mute", "Texture": "res://assets/emotes/pipo-popupemotes018.png" },
	{ "Name": "bulb", "Texture": "res://assets/emotes/pipo-popupemotes017.png" },
	{ "Name": "undecided", "Texture": "res://assets/emotes/pipo-popupemotes019.png" },
	{ "Name": "ghost", "Texture": "res://assets/emotes/pipo-popupemotes036.png" },
	{ "Name": "summon", "Texture": "res://assets/emotes/pipo-popupemotes046.png" },
	{ "Name": "talk", "Texture": "res://assets/emotes/pipo-popupemotes163.png" },
	{ "Name": "action", "Texture": "res://assets/emotes/pipo-popupemotes168.png" },
	{ "Name": "curious", "Texture": "res://assets/emotes/pipo-popupemotes002.png" },
	{ "Name": "demon", "Texture": "res://assets/emotes/pipo-popupemotes083.png" },
	{ "Name": "angel", "Texture": "res://assets/emotes/pipo-popupemotes082.png" },
	{ "Name": "heart", "Texture": "res://assets/emotes/pipo-popupemotes009.png" },
]

# Called when the node enters the scene tree for the first time.
func _ready():
	emotes = JSON.parse(JSON.print(emotes)).result
	texture = null
	$Anim.stop()
	pass # Replace with function body.

func show_emote(name, is_once):
	for emote in emotes:
		if emote.Name == name:
			$Anim.stop()
			texture = load(emote.Texture)
			visible = true
			if is_once:
				$Anim.play("default_once")
			else:
				$Anim.play("default_loop")

func hide_emote():
	visible = false
	$Anim.stop()

func _on_Anim_animation_finished(anim_name):
	hide_emote()
	pass # Replace with function body.
