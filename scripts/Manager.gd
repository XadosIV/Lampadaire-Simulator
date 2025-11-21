extends Node3D

@onready var bumpers : Node3D = $Bumpers
@onready var Ascenseur: Node3D = $Ascenseur

func RemoveBumpers():
	bumpers.global_position.y = -100
	Ascenseur.global_position.y = -100
