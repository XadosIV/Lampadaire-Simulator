extends Node3D

var screamerTrigger = false
@onready var pos = $Player.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Player.position = pos
	if screamerTrigger:
		screamer()
	
func screamer():
	$Player.get_node("Camera3D").look_at(Vector3(0,2.5,5))

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	screamerTrigger = true
	$ScreamerPadaire.timerStart = true
