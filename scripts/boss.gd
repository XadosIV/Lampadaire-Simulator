extends Node3D

@onready var Hpbar : BossHp = $BossHp

func got_shot():
	Hpbar.take_damage(25)
