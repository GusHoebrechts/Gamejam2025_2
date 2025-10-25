extends Node2D

var gargoyle = preload("res://scripting/Enemies/gargoyle.tscn")
@onready var player = get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
var gargoyle_spawned = false
var inst

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(player.global_position.x >= 200 and !gargoyle_spawned):
		gargoyle_spawned = true
		inst = gargoyle.instantiate()
		var offset = Vector2(0,-100)
		inst.global_position = player.global_position + offset
		add_child(inst)
	if(gargoyle_spawned):
		inst.move(player)
	pass
