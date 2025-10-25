extends Area2D

@export var respawn:Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		respawn.position=position
