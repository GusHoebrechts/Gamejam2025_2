extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_sprite():
	$RigidBody2D/AnimatedSprite2D.frame = 1
	pass

func _on_timer_timeout() -> void:
	change_sprite()
	pass # Replace with function body.
