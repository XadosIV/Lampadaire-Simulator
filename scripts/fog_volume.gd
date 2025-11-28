extends FogVolume

@export var volumePasBoss : FogMaterial
@export var volumeBoss : FogMaterial

var timeto = 5
var defoged = false

func _ready() -> void:
	material = volumePasBoss

func defog():
	defoged = true
	visible = !visible

func _process(delta: float) -> void:
	if(defoged):
		timeto -= delta
		if(timeto <= 0):
			visible = true
			defoged = false
			material = volumeBoss
