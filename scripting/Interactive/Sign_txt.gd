extends Node2D


@export var message= "I should have been usefull"

func _ready() -> void:
	$InteractSphere.message =message
