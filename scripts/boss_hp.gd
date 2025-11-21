extends Control
class_name BossHp

@export var tete : Control
@export var debut : Node2D
@export var fin : Node2D

@export var max_hp := 100

var hp := 100
var damage_timer := 0.0

func _ready() -> void:
	hp = max_hp
	set_hp(hp)

func set_hp(value: int) -> void:
	hp = clamp(value, 0, max_hp)
	var t := float(hp) / float(max_hp)
	tete.position.x = lerp(debut.position.x, fin.position.x, t)

func _process(delta: float) -> void:
	damage_timer += delta
	if damage_timer >= 2.0:
		damage_timer = 0.0
		take_damage(10)

func take_damage(amount: int) -> void:
	hp = max(hp - amount, 0)
	set_hp(hp)
