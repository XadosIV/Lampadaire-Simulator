extends Node3D

var speed = 10

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var forward = -global_transform.basis.z
	global_transform.origin += forward * speed * delta
