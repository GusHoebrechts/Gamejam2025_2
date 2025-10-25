extends CharacterBody2D

const SPEED = 110
const JUMP_VELOCITY = -170

enum State{Idle,Chase}
var state=State.Idle
var check_dst = 10

@onready var rc_low: RayCast2D  = $RayCast_Low
@onready var rc_high: RayCast2D = $RayCast_High
@onready var rc_ground: RayCast2D = $RayCast_Ground
@onready var timer =$Timer
@onready var stuckTimer =$Timer2
@onready var IdleTimer =$IdleTimer
@export var player:CharacterBody2D
@export var ground:TileMapLayer

var direction=1
var grounded
var jump=false
var last_x=0
var dx=0
var x
var y
var rng = RandomNumberGenerator.new()
var my_random_number=0

func _ready() -> void:
	x = rc_ground.position.x
	y = rc_ground.position.y
	my_random_number = rng.randf_range(0, 10.0)
	

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
			$AnimatedSprite2D.flip_h = true
			print("idle")
			_walk_arround()
			
			
		State.Chase:
			print("chasing")
			$AnimatedSprite2D.play('Walking')
			dx=abs(last_x-global_position.x)
			if(stuckTimer.time_left<=0):
				last_x=global_position.x
				stuckTimer.start(0.75)
			dx = abs(global_position.x - last_x)
			if(player.position.x-self.position.x>0):
				direction = 1
				$AnimatedSprite2D.flip_h = false
				_flip_rays()
			else: 
				direction =-1
				$AnimatedSprite2D.flip_h = true
				_flip_rays()
			if(grounded):
				velocity.x=SPEED*direction
			if(dx<=0):
				if(jump):
					jump=false
					velocity.y=JUMP_VELOCITY
				state=State.Idle
				
		
func _look_for_player():
	if rc_high.is_colliding() or rc_low.is_colliding():
		var colliderH = rc_high.get_collider()
		var colliderL = rc_low.get_collider()
		if (colliderH==player or colliderL==player):
			state=State.Chase
			timer.start(5)
		if(colliderL==ground and not rc_high.is_colliding()):
			jump=true
	if state==State.Chase and (timer.time_left<=0):
			state=State.Idle
	move_and_slide()
func _flip_rays():
	if(direction==-1):
		rc_low.rotation_degrees=180
		rc_high.rotation_degrees=180
		rc_ground.position= Vector2(x*direction,y) #bad code
	else:
		rc_low.rotation_degrees=0
		rc_high.rotation_degrees=0
		rc_ground.position= Vector2(x,y)
		
func _walk_arround():
	if(IdleTimer.time_left<=0):
		last_x=global_position.x
		IdleTimer.start(my_random_number)
	velocity.x=SPEED/2*direction
	if(dx<=0&&stuckTimer.time_left<=0):
		direction=-direction
		last_x=global_position.x
		stuckTimer.start(0.75)
	
	
