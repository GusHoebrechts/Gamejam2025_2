extends Node2D
@export var next_level:String

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		get_tree().change_scene_to_file(next_level)

func _set_next_level(level: String) -> void:
	next_level=level
	
