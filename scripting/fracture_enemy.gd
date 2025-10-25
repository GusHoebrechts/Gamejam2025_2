extends CharacterBody2D

const SPEED = 130
const JUMP_VELOCITY = -50

enum State{Idle,Chase}
var state=State.Idle
var check_dst = 10

@onready var rc_low: RayCast2D  = $RayCast_Low
@onready var rc_high: RayCast2D = $RayCast_High
@onready var rc_ground: RayCast2D = $RayCast_Ground
@onready var timer =$Timer
@onready var stuckTimer =$Timer2

@export var player:CharacterBody2D
@export var ground:TileMapLayer

var direction
var grounded
var jump
var last_x

func _ready():
	last_x =global_position.x
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	_look_for_player()
	
	if(rc_ground.is_colliding()):
		if(rc_ground.get_collider()==ground):
			grounded=true
	match state:
		State.Idle:
			$AnimatedSprite2D.play("Idle")
			
		State.Chase:
			$AnimatedSprite2D.play('Walking')
			stuckTimer.start(0.1)
			if(player.position.x-self.position.x>0):
				direction = 1
			else: 
				direction =-1
			if(grounded):
				velocity.x=SPEED*direction
			
		
func _look_for_player():
	if rc_high.is_colliding() or rc_low.is_colliding():
		var colliderH = rc_high.get_collider()
		var colliderL = rc_low.get_collider()
		if (colliderH==player or colliderL==player):
			state=State.Chase
			timer.start(5)
		if(colliderL==ground and not colliderH==ground):
			jump=true
	if state==State.Chase and (timer.time_left<=0):
			state=State.Idle
			print("here")
	move_and_slide()
	
	
