extends Area2D
var player: Node = null
var message= "Fack my chungus life"
func _ready() -> void:
	$AnimatedSprite2D.play("Idle")

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		player = body
		$AnimatedSprite2D.play("Interactable")
		if not player.interact.is_connected(_on_player_interact):
			player.interact.connect(_on_player_interact)


func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		$AnimatedSprite2D.play("Idle")
		if not player.interact.is_connected(_on_player_interact):
			player.interact.disconnect(_on_player_interact)

func _on_player_interact():
	var ui := get_tree().get_first_node_in_group("UI")
	ui.call("show_text", message)
