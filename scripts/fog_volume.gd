extends FogVolume

var timeto = 5
var defoged = false

func defog():
	defoged = true
	visible = !visible

func _process(delta: float) -> void:
	if(defoged):
		timeto -= delta
		if(timeto <= 0):
			visible = true
			defoged = false
