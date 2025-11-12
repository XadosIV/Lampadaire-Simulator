extends CharacterBody3D

@export var movement_speed: float = 4.0
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@export var canFollow : bool = false

var dist_to_player = 2

@export var player: Player

func _ready() -> void:
	set_movement_target(player.global_position)


func _process(delta) -> void:
	if(canFollow):
		look_at(player.position, Vector3.UP)
		set_movement_target(player.global_position)


func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
	
func _physics_process(delta: float) -> void:
	if (global_position - player.global_position).length() < dist_to_player:
		animation_player.play("bonk")
	else:
		animation_player.stop()
	if navigation_agent.is_navigation_finished():
		return
	else:
		var destination = navigation_agent.get_next_path_position()
		var local_destination = destination - global_position
		var direction = local_destination.normalized()
		velocity = direction * 4
		move_and_slide()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	player.hp -= 20
	

func trigger_pursuit(body: Node3D) -> void:
	print("Lesgo")
	if(body.name == "Player"):
		canFollow = !canFollow
	
