extends Node3D

@export var light = true
@export var jaune = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$OmniLight3D.visible = light

	if jaune:
		var mat := StandardMaterial3D.new()
		mat.albedo_color = Color(1, 1, 0)

		for child in get_children():
			if child is not OmniLight3D:
				child.material_override = mat
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
