extends Control
@onready var first_level = preload("res://map.tscn")
@export var credit : Control


func _on_startbutton_button_down() -> void:
	get_tree().change_scene_to_packed(first_level)

func _on_leavebutton_button_down() -> void:
	get_tree().quit()


func _on_creditbutton_button_down() -> void:
	print("test")
	credit.visible = true
	visible = false
