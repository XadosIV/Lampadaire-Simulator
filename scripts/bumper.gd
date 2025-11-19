extends Node3D

@export var strength : float = 10

func bounce(body: Node3D):
	if(body.name == "Player"):
		body.velocity.y = max(strength,body.velocity.y)
