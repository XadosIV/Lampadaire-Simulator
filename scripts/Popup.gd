extends Control

func _on_quitter_pressed() -> void:
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_winning() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Menu_simul.tscn")
