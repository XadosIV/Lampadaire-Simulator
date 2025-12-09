extends Node3D

@export var popup : Control
var popup_done := false
signal defog
signal start_boss

func move_to_center():
	var center_pos = Vector3(0, 50, 0)
	emit_signal("defog")
	var tween = create_tween()
	$Multipadaire.Hpbar.visible = true
	tween.tween_property(self, "position", center_pos, 5.0)


func _on_body_entered_popup(body: Node3D) -> void:
	if popup_done:
		return
	if body.name == "Player":
		emit_signal("start_boss")
		popup_done = true
		popup.visible = true
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
