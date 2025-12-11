extends Control

@export var menu : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_leavebutton_button_down() -> void:	
	menu.visible = true
	visible = false
