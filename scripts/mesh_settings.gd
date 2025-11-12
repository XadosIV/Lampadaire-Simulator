extends Node3D

@export var light = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$OmniLight3D.visible = light


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
