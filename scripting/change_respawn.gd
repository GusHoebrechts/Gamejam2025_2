extends Area2D

@export var respawn:Node2D
var first = true

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" && first:
		respawn.position=position
		$AnimatedSprite2D.play("default")
		first = false
