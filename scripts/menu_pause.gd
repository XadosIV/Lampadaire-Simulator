extends Control

func _on_leavebutton_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Menu_simul.tscn")


func _on_resumebutton_pressed() -> void:
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
