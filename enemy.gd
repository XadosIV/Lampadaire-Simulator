extends CharacterBody3D

@export var movement_speed: float = 4.0
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

@export var player: Node3D

func _ready() -> void:
	set_movement_target(player.global_position)

func _process(delta) -> void:
	if not $VisibleOnScreenNotifier3D.is_on_screen() or (position - player.position).length() > 5:
		look_at(player.position, Vector3.UP)
		set_movement_target(player.global_position)
	else:
		set_movement_target(position)
		


func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
	
func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return
	var destination = navigation_agent.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	velocity = direction * 4
	move_and_slide()
