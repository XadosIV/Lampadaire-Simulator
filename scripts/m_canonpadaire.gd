extends CharacterBody3D

signal shoot
@onready var animplayer: AnimationPlayer = $AnimationPlayer
@onready var padraies: Node3D = $Root
var hasShot = false
@export var isDecoration = false

@onready var boss = get_node("../../Multipadaire")

var player

func _ready():
	player = get_node("/root/Map/Player")
	if not player:
		player = get_node("/root/BossArena/Player")
	if(!isDecoration):
		var padaires:Array[Node] =padraies.get_children()
		for x in padaires:
			x.turnYellow()
	
	animplayer.play("fly")
	

func _process(_delta):
	if isDecoration:
		look_at(player.position)
	if hasShot:
		look_at(boss.position + Vector3(0,15,0))

func shooting(body:Node3D):
	if isDecoration: return
	
	if (body.name == "Player" && !hasShot):
		emit_signal("shoot")
		animplayer.play("shot")
		hasShot = true
