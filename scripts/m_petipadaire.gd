extends CharacterBody3D

@export var patrol_distance: float = 5.0
@export var speed: float = 4.0

@onready var area = $Area3D
var point_a: Vector3
var point_b: Vector3
var going_to_b := true
var player: Node3D = null

var charging := false
var preparing := false
@export var prepare_time_min := 0.5
@export var prepare_time_max := 2.5
@export var overcharge_speed := 20.0   # vitesse très rapide
var prepare_timer := 0.0
var charge_target: Vector3

var last_charge_distance

func _ready():
	point_a = global_transform.origin
	# Devant = -Z en Godot (avant du node)
	point_b = point_a + (-global_transform.basis.z * patrol_distance)

	if Engine.is_editor_hint(): return

	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _physics_process(delta):
	if player == null:
		_patrol(delta)
	else:
		_attack_player(delta)



func _patrol(_delta):
	var target = point_b if going_to_b else point_a
	var dir = (target - global_transform.origin).normalized()

	velocity = dir * speed
	move_and_slide()

	look_at(target, Vector3.UP)


	if global_transform.origin.distance_to(target) < 1:
		going_to_b = not going_to_b

func _attack_player(delta):
	if preparing:
		# L’ennemi regarde le joueur et attend
		look_at(player.global_transform.origin, Vector3.UP)
		prepare_timer -= delta
		velocity = Vector3.ZERO

		# Quand la préparation est finie, on calcule le point à dépasser
		if prepare_timer <= 0:
			preparing = false
			charging = true

			var to_player = player.global_transform.origin - global_transform.origin
			to_player = to_player.normalized()

			# Point situé derrière le joueur (il le traverse)
			charge_target = player.global_transform.origin + to_player * 10.0
		return

	if charging:
		# Charge très rapide vers le point derrière le joueur
		look_at(charge_target, Vector3.UP)
		var dir = (charge_target - global_transform.origin).normalized()
		velocity = dir * overcharge_speed
		
		var hit = move_and_collide(velocity * delta)
		if hit:
			_on_charge_collision(hit)

		
		var charge_distance = global_transform.origin.distance_to(charge_target)
		# Quand il a dépassé la cible, on arrête la charge
		if charge_distance < 2.0 or last_charge_distance == charge_distance:
			charging = false
			player = null
		
		last_charge_distance = charge_distance
		return


func _on_body_entered(body):
	if body.name == "Player":
		player = body
		preparing = true
		prepare_timer = randf_range(prepare_time_min, prepare_time_max)
		velocity = Vector3.ZERO

func _on_body_exited(body):
	if body == player:
		# Ne rien faire si préparation ou charge en cours
		if preparing or charging:
			return
		player = null

func _on_charge_collision(collision):
	var body = collision.get_collider()
	if body and body.name == "Player":
		var push_dir = (body.global_transform.origin - global_transform.origin).normalized()
		if body.has_method("apply_bump"):
			body.apply_bump(push_dir * 20.0)   # intensité
