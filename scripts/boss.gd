extends Node3D

@onready var Hpbar : BossHp = $BossHp

func got_shot():
	Hpbar.take_damage(25)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name != "Player" and body.name != "Wall": # dans le doute
		body.get_parent().queue_free()
