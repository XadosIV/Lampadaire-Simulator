extends CharacterBody3D

signal shoot
@onready var animplayer: AnimationPlayer = $AnimationPlayer
var hasShot = false
@export var isDecoration = false


var player

func _ready():
	player = get_node("/root/Map/Player")
	if not player:
		player = get_node("/root/BossArena/Player")

func _process(_delta):
	if isDecoration:
		look_at(player.position)

func shooting(body:Node3D):
	if isDecoration: return
	
	if (body.name == "Player" && !hasShot):
		emit_signal("shoot")
		animplayer.play("shot")
		hasShot = true
