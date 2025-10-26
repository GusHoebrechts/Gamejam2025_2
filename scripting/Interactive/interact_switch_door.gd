extends Area2D

var player: Node = null
var flipped=false
var interactable=true

@onready var collisionKillBox: CollisionShape2D = $LaserWall/KillBox/CollisionShape2D
@onready var collisionBlockBox: CollisionShape2D = $LaserWall/BlockBox/BlockCollisionShape
@onready var laserWall: AnimatedSprite2D = $LaserWall


func _ready() -> void:
	$Switch.play("default")
	laserWall.play("Idle")
	collisionBlockBox.disabled=false
	collisionKillBox.disabled=false

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		player = body
		if not player.interact.is_connected(_on_player_interact):
			player.interact.connect(_on_player_interact)

func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		if player.interact.is_connected(_on_player_interact):
			player.interact.disconnect(_on_player_interact)

func _on_player_interact():
	if(interactable):
		interactable=false
		if(not flipped):
			flipped=true
			$Switch.play("flipped")
			_deactivate()
		else:
			flipped=false
			$Switch.play("default")
			_activate()

func _deactivate():
	laserWall.play("Deactivate")
	collisionBlockBox.disabled=true
	collisionKillBox.disabled=true
	interactable=true
func _activate():
	laserWall.play("Activate")
	await laserWall.animation_finished
	laserWall.play("Idle")
	collisionBlockBox.disabled=false
	collisionKillBox.disabled=false
	interactable=true
	
