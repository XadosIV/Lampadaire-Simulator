extends Node3D

"""
Si le joueur a la tête à gauche, désactive celui de gauche
Idem pour la droite

L'idée étant de pouvoir voir un peu le lampadaire avant de déclencher le screamer
"""

@onready var player = get_viewport().get_camera_3d().get_parent()

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	# positive gauche
	if player.rotation_degrees.y < 0:
		$Left.visible = false
		$Right.visible = true
	# negative droite
	else:
		$Left.visible = true
		$Right.visible = false
	
