extends Area2D
@export var teleport:Node2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if(body.name=="Player"):
			body.add_score(-50)
			call_deferred("_respawn",body)
		
func _respawn(player: CharacterBody2D) -> void:
	player._reset()
