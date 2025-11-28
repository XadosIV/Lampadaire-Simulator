extends Node3D

@export var light = true
@export var jaune = false
@export var bossLight = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var l : OmniLight3D = $OmniLight3D
	
	l.visible = light
	
	if bossLight:
		l.omni_range = 25
		l.light_energy = 30
	else:
		l.omni_range = 5
		l.light_energy = 2

	if jaune:
		var mat := StandardMaterial3D.new()
		mat.albedo_color = Color(1, 1, 0)
		print("yup")

		for child in get_children():
			if child is not OmniLight3D:
				child.material_override = mat
		

func turnYellow():
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(1, 1, 0)

	for child in get_children():
		if child is not OmniLight3D:
			child.material_override = mat
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
