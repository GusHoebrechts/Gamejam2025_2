extends CanvasLayer

@onready var label = $Label
@export var player:CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "Score:" + str(get_score())
	
	pass # Replace with function body.
func get_score():
	return player.get_score()
func update_score():
	var new_score = player.get_score()
	label.text = "Score:" + str(new_score)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
