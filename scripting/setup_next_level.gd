extends Node2D

func _set_next_level(level: String) -> void:
	$Area2D.call("_set_next_level",level)
