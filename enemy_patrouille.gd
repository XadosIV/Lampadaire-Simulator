extends CharacterBody3D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@export var movement_speed: float = 2.0
@export var point_a: Node3D
@export var point_b: Node3D
@export var wait_time: float = 1.0
@onready var agent: NavigationAgent3D = $"NavigationAgent3D"

var to_b := true
var wait := 0.0

func _ready() -> void:
	if point_a and point_b:
		_set_target(point_a.global_position)

func _process(delta: float) -> void:
	if not point_a or not point_b:
		return
	if agent.is_navigation_finished() or agent.distance_to_target() < 0.2:
		if wait <= 0.0:
			wait = wait_time
		else:
			wait -= delta
			if wait <= 0.0:
				to_b = !to_b
				_set_target((point_b if to_b else point_a).global_position)
				animation_player.play("bonk")
				

func _physics_process(delta: float) -> void:
	if agent.is_navigation_finished():
		velocity = Vector3.ZERO
		move_and_slide()
		return
	var dst := agent.get_next_path_position()
	var dir := (dst - global_position).normalized()
	velocity = dir * movement_speed
	move_and_slide()

func _set_target(p: Vector3) -> void:
	agent.set_target_position(p)
