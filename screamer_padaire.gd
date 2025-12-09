extends Node3D


var timer = 3
@export var speed: float = 35.0

@export var audioStreamPlayer : AudioStreamPlayer3D

var onetime = false

func _process(delta):
	timer -= delta
	if timer < 0:
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
