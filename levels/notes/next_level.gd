extends Node2D
var next_level

func _ready() -> void:
	$Player.call("_set_jump", -230)
