extends Area2D

var player: Node = null
var flipped=false
@export var spawn_scene: PackedScene
@export var player_ref: CharacterBody2D 

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		player = body
		if not player.interact.is_connected(_on_player_interact):
			player.interact.connect(_on_player_interact)


func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		print("disconnect2")
		if player.interact.is_connected(_on_player_interact):
			player.interact.disconnect(_on_player_interact)

func _on_player_interact():
	if(not flipped):
		flipped=true
		$AnimatedSprite2D.play("flipped")
		_spawn_entity()
	else:
		flipped=false
		$AnimatedSprite2D.play("default")
	
func _spawn_entity():
	if not spawn_scene: return
	var new_instance = spawn_scene.instantiate()
	new_instance.call("_player_ref", player_ref)
	new_instance.call("_aggro")
	new_instance.global_position = global_position + Vector2(70, -12)		
	get_tree().current_scene.add_child(new_instance)
	
