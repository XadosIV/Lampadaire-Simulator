extends Node3D

@onready var Hpbar : BossHp = $BossHp
@onready var canons : Array[CharacterBody3D] = [$Canonpadaire,$Canonpadaire2,$Canonpadaire3,$Canonpadaire4]


@export var maxShootTimer = 0.4
var shootTimer = maxShootTimer

func got_shot():
	Hpbar.take_damage(25)

func activateCanons():
	for canon in canons:
		canon.isDecoration = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name != "Player" and body.name != "Wall": # dans le doute
		body.get_parent().queue_free()

func _process(delta: float) -> void:
	shootTimer -= delta
	if(shootTimer <= 0):
		canons.pick_random().shootingPlayer()
		shootTimer = maxShootTimer
