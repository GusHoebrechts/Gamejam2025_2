extends Node2D
var projectile = preload("res://scripting/Enemies/water_projectile.tscn")



@onready var himself = get_node("CharacterBody2D")
@export var player:CharacterBody2D
var SPEED = 50
var direction = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterBody2D/AnimatedSprite2D.play()
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move(player)
	
	pass
	

func move(player):
	if(player.global_position.x-himself.global_position.x>10):
		direction = 1
	elif(player.global_position.x-himself.global_position.x<-10): 
		direction =-1
	else:
		direction = 0
	himself.velocity.x=SPEED*direction
	himself.move_and_slide()
	pass

func _on_timer_timeout() -> void:
	$CharacterBody2D/AnimatedSprite2D.play()
	var inst = projectile.instantiate()
	var offset = Vector2(0,24)
	inst.global_position = himself.global_position + offset
	get_parent().add_child(inst)
	
	
	pass # Replace with function body.
