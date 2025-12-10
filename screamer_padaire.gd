extends Node3D


var timer = 2
@export var speed: float = 35.0

@export var audioStreamPlayer : AudioStreamPlayer3D

var onetime = false

var timerStart = false

func _process(delta):
	if not timerStart: 
		return
	timer -= delta
	if timer < 0.5:
		$Lampadaire.turnOff()
	
	if timer < 0:
		$Lampadaire.turnOn()
		global_transform.origin += -global_transform.basis.z * speed * delta
		$AnimationPlayer.play("screamerBonk")
		if not onetime:
			audioStreamPlayer.play()
			onetime = true
		if position.z < -75:
			timer = 2
			position = Vector3(0,0,-15.31417)
			$AnimationPlayer.play("RESET")
			onetime = false
