extends CanvasLayer

func _ready()-> void:
	hide()
	pass
	

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
		


func toggle_pause():
	if Engine.time_scale == 0:
		Engine.time_scale = 1
		hide()
	else:
		Engine.time_scale = 0
		show()



func _on_resume_pressed() -> void:
	Engine.time_scale = 1
	hide()
	pass # Replace with function body.



func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
