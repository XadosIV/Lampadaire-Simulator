extends Node3D

@export var strength : float = 10
@export var anim_player : AnimationPlayer

func bounce(body: Node3D):
	if body.name == "Player":
		anim_player.play("BUMP")
		
