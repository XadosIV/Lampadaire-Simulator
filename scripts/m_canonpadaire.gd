extends CharacterBody3D

signal shoot
@onready var animplayer: AnimationPlayer = $AnimationPlayer
var hasShot = false

func shooting(body:Node3D):
	if (body.name == "Player" && !hasShot):
		emit_signal("shoot")
		animplayer.play("shot")
		hasShot = true
