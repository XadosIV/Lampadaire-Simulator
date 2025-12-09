extends Node3D

signal defog

func move_to_center():
	var center_pos = Vector3(0, 50, 0)
	emit_signal("defog")
	var tween = create_tween()
	$Multipadaire.Hpbar.visible = true
	tween.tween_property(self, "position", center_pos, 5.0)
