extends Node2D

@onready var pause_menu = $PauseMenuLayer/PauseMenu
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

#func _process(delta):
#	if Input.is_action_just_pressed("pause"):
#		toggle_pause()
		


func toggle_pause():
	if Engine.time_scale == 0:
		Engine.time_scale = 1
		pause_menu.hide()
	else:
			Engine.time_scale = 0
			pause_menu.show()
	
