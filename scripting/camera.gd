extends Camera2D

@export var player: Node2D

func _physics_process(_delta):
	if player:
		position = player.global_position
