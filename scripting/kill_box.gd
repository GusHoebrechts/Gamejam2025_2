extends Area2D
@export var teleport:Node2D
var player:CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if(body.name=="Player"):
			player=body
			call_deferred("_respawn",body)
		
func _respawn(player: CharacterBody2D) -> void:
	teleport = get_tree().get_first_node_in_group("Respawn") as Node2D
	player.set_deferred("global_position", teleport.global_position)
	player.set_deferred("velocity", Vector2.ZERO)
