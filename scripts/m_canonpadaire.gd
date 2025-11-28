extends CharacterBody3D

signal shoot
@onready var animplayer: AnimationPlayer = $AnimationPlayer

func shooting(body:Node3D):
	if (body.name == "Player"):
		emit_signal("shoot")
		animplayer.animation_get_next("shot")
		print("Yay")
