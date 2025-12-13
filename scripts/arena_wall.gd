extends Node3D

@onready var col: CollisionShape3D = $Wall/CollisionShape3D
var disabled = false
var timeto = 5

func disableColl():
	col.set_deferred("disabled",true)
	disabled = true
	
func _process(delta: float) -> void:
	if(disabled):
		timeto -= delta
		if(timeto <= 0):
			visible = true
			disabled = false
			col.set_deferred("disabled",false)
