extends CharacterBody3D

@export var lampadaireNode : PackedScene

signal shoot
@onready var animplayer: AnimationPlayer = $AnimationPlayer
@onready var padraies: Node3D = $Root
var hasShot = false
@export var isDecoration = false
@export var decorationBullet : PackedScene
var decorationHasShot := false


@onready var boss = get_node("../../Multipadaire") # ça va exploser des trucs ça si on le met ailleurs que dans la boss arena mdr
@onready var boss_target = boss.get_node("Area3D/CollisionShape3D") # ça va exploser des trucs ça si on le met ailleurs que dans la boss arena mdr

var player

@export var maxShootTimer = 0.4
var shootTimer = maxShootTimer

func _ready():
	player = get_node_or_null("/root/Map/Player")
	if not player:
		player = get_node("/root/BossArena/Player")
	
	animplayer.play("fly")
	
	if not isDecoration:
		for i in $Root.get_children():
			i.turnFriendly()
	

func _process(_delta):
	if isDecoration:
		look_at(player.position)
	if hasShot:
		look_at(boss_target.global_position)
		shootTimer -= _delta
		if shootTimer <= 0:
			shootTimer = maxShootTimer
			var projectile : Node3D = lampadaireNode.instantiate()
			get_parent().add_child(projectile)
			projectile.position = position
			projectile.look_at(boss_target.global_position)

func shooting(body:Node3D):
	if isDecoration: return
	
	if (body.name == "Player" && !hasShot):
		emit_signal("shoot")
		animplayer.play("shot")
		hasShot = true

func shootingPlayer():
	if isDecoration:
		shoot_decoration_bullet()
		decorationHasShot = true

func shoot_decoration_bullet():
	if decorationBullet == null:
		push_warning("Decoration has no bullet scene assigned!")
		return
		
	animplayer.play("shot")
	
	var projectile: Node3D = decorationBullet.instantiate()
	
	get_parent().add_child(projectile)
	projectile.global_transform = $ProjectileStart.global_transform
	projectile.get_player_pos(player.position)
	
	projectile.look_at(player.global_position)
