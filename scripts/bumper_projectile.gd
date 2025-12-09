extends Node3D

@export var strength: float = 10
@export var anim_player: AnimationPlayer
@export var speed: float = 10
@export var lifespan: float = 10

var velocity: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	lifespan -= delta
	if lifespan <= 0:
		die()
	# Move bullet in world space
	global_translate(velocity * speed * delta)

func bounce(body: Node3D):
	if body.name == "Player":
		anim_player.play("BUMP")
		if "velocity" in body:
			body.velocity.y = max(strength, body.velocity.y)

func get_player_pos(player_pos: Vector3):
	# Compute full 3D vector toward player
	velocity = (player_pos - global_transform.origin).normalized()

func die():
	queue_free()
