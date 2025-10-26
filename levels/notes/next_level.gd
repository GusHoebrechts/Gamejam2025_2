extends Node2D
var next_level

func _ready() -> void:
	$Player.call("_set_jump", -230)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
