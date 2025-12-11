extends Node3D

@onready var Hpbar : BossHp = $BossHp
@onready var canons : Array[CharacterBody3D] = [$Canonpadaire,$Canonpadaire2,$Canonpadaire3,$Canonpadaire4]
@export var maxShootTimer = 1
@export var explosion_scene: PackedScene
var shootTimer = maxShootTimer
var hits = 0
signal boss_dead
var exploded := false

func explode_all() -> void:
	if exploded:
		return
	exploded = true

	var markers = $Explosion.get_children()

	for i in range(80):
		var marker = markers[randi() % markers.size()]
		
		var e = explosion_scene.instantiate()
		e.global_transform = marker.global_transform
		get_tree().current_scene.add_child(e)
		await get_tree().create_timer(randf_range(0.05, 0.12)).timeout



func got_shot():
	Hpbar.take_damage(25)
	hits += 1

	if hits == 4:
		await explode_all()
		emit_signal("boss_dead")


func activateCanons():
	for canon in canons:
		canon.canShot = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name != "Player" and body.name != "Wall": # dans le doute
		body.get_parent().queue_free()

func _process(delta: float) -> void:
	shootTimer -= delta
	if(shootTimer <= 0):
		canons.pick_random().shootingPlayer()
		shootTimer = maxShootTimer
