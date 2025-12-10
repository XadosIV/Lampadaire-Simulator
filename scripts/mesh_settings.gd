extends Node3D

@export var light = true
@export var jaune = false
@export var bossLight = false

var mat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var l : OmniLight3D = $OmniLight3D
	mat = $interieur.get_surface_override_material(0)
	
	if light:
		turnOn()
	else:
		turnOff()
	
	
	if bossLight:
		l.omni_range = 25
		l.light_energy = 30
	else:
		l.omni_range = 10
		l.light_energy = 2

	if jaune:
		turnFriendly()
		
func turnFriendly():
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0, 1, 0)
	for child in get_children():
		if child is not OmniLight3D:
			child.material_override = mat

func turnOn():
	$OmniLight3D.visible = true
	$interieur.set_surface_override_material(0, mat)

func turnOff():
	$OmniLight3D.visible = false
	$interieur.set_surface_override_material(0, null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
