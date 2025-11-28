extends CharacterBody3D

signal shoot
@onready var animplayer: AnimationPlayer = $AnimationPlayer
@export var hasShot = false

var player

func _ready():
	player = get_node("/root/Map/Player")

func _process(_delta):
	if isDecoration:
		look_at(player.position)


func shooting(body:Node3D):
	if (body.name == "Player" && !hasShot):
		emit_signal("shoot")
		animplayer.play("shot")
		hasShot = true
