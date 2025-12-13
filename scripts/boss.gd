extends Node3D

@onready var Hpbar : BossHp = $BossHp
@onready var canons : Array[CharacterBody3D] = [$Canonpadaire,$Canonpadaire2,$Canonpadaire3,$Canonpadaire4]
@export var maxShootTimer = 1
@export var explosion_scene: PackedScene
@export var petipadaire : PackedScene
var shootTimer = maxShootTimer
var hits = 0
signal boss_dead
var exploded := false
var dying = false

@export var fade_duration := 6.5
var fade_time := 0.0
var fading := false
var fade_materials : Array[BaseMaterial3D] = []

func start_fade():
	fade_materials.clear()
	fade_time = 0.0
	fading = true

	_collect_materials($Root)
	for canon in canons:
		_collect_materials(canon.get_node("Root"))

func _collect_materials(node: Node):
	for child in node.get_children():
		if child is MeshInstance3D:
			for i in child.get_surface_override_material_count():
				var mat = child.get_active_material(i)
				if mat:
					mat = mat.duplicate()
					mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
					child.set_surface_override_material(i, mat)
					fade_materials.append(mat)
		else:
			_collect_materials(child)

func all_invisible():
	$Root.visible = false
	for canon in canons:
		canon.visible = false

func explode_all() -> void:
	dying = true
	if exploded:
		return
	exploded = true

	start_fade()

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
	var enemyNode = get_node("../Enemies")
	for marker in enemyNode.get_children():
		var p : Petipadaire = petipadaire.instantiate()
		p.position = marker.position
		p.patrol_distance = 10
		var area : CollisionShape3D = p.get_node("Area3D/CollisionShape3D")
		var shape : SphereShape3D = area.shape
		shape.radius = 25
		enemyNode.add_child(p)
		

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name != "Player" and body.name != "Wall": # dans le doute
		body.get_parent().queue_free()

func _process(delta: float) -> void:
	if fading:
		fade_time += delta
		var t := fade_time / fade_duration
		for mat in fade_materials:
			mat.albedo_color.a = lerp(1.0, 0.0, t)
		
		if t >= 1:
			all_invisible()

	if dying: return
	shootTimer -= delta
	if(shootTimer <= 0):
		canons.pick_random().shootingPlayer()
		shootTimer = maxShootTimer
