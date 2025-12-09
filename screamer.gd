extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	screamer() # Replace with function body.

func screamer():
	$Player.get_node("Camera3D").look_at(Vector3(0,2.5,5))
	
