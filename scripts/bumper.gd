extends Node3D

@export var strength : float = 10

func bounce(body: Node3D):
	print("Maybe?")
	if(body.name == "Player"):
		body.velocity.y = strength
