extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_bttn_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")
	pass # Replace with function body.


func _on_level_2_bttn_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/Next_Level.tscn")
	pass # Replace with function body.
