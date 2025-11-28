extends CharacterBody3D

signal shoot
@onready var animplayer: AnimationPlayer = $AnimationPlayer

@export var isDecoration = false
var player

func _ready():
	player = get_node("/root/Map/Player")

func _process(_delta):
	if isDecoration:
		look_at(player.position)


func shooting(body:Node3D):
	if isDecoration: return
	
	if (body.name == "Player"):
		emit_signal("shoot")
		animplayer.animation_get_next("shot")
		print("Yay")
