extends CharacterBody2D

const SPEED = 110
const JUMP_VELOCITY = -170

enum State{Idle,Chase,Death,Aggro_Chase}
var state=State.Idle
var check_dst = 10

@onready var rc_low: RayCast2D  = $RayCast_Low
@onready var rc_high: RayCast2D = $RayCast_High
@onready var rc_ground: RayCast2D = $RayCast_Ground
@onready var timer =$Timer
@onready var stuckTimer =$Timer2
@onready var IdleTimer =$IdleTimer
@onready var RestTimer = $RestTimer

@export var player:CharacterBody2D
@export var ground:TileMapLayer
@export var hazard:TileMapLayer

var direction=1
var grounded
var jump=false
var last_x=0
var dx=0
var x
var y
var rng = RandomNumberGenerator.new()
var my_random_number=0
var 	dead =false
var aggro =false

func _ready() -> void:
	$AnimatedSprite2D2.visible=false
	x = rc_ground.position.x
	y = rc_ground.position.y
	my_random_number = rng.randf_range(0, 10.0)
	self.add_to_group("Enemy")
	if player == null:
		player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	if ground == null:
		ground = get_tree().get_first_node_in_group("Ground")
	if hazard == null:
		hazard = get_tree().get_first_node_in_group("Hazard")
	

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
			_walk_arround()
		State.Chase:
			$AnimatedSprite2D.play('Walking')
			dx=abs(last_x-global_position.x)
			if(stuckTimer.time_left<=0):
				last_x=global_position.x
				stuckTimer.start(0.75)
			dx = abs(global_position.x - last_x)
			if(player.position.x-self.position.x>0):
				direction = 1
				_flip_rays()
			else: 
				direction =-1
				_flip_rays()
			if(grounded):
				velocity.x=SPEED*direction
			if(dx<=0):
				if(jump):
					jump=false
					velocity.y=JUMP_VELOCITY
				if(timer.time_left<=0):
					state=State.Idle
		State.Death:
			velocity=Vector2.ZERO
		State.Aggro_Chase:
			if(aggro):
				timer.start(5)
			$AnimatedSprite2D.play('Walking')
			dx=abs(last_x-global_position.x)
			if(stuckTimer.time_left<=0):
				last_x=global_position.x
				stuckTimer.start(0.75)
			dx = abs(global_position.x - last_x)
			if(player.position.x-self.position.x>0):
				direction = 1
				_flip_rays()
			else: 
				direction =-1
				_flip_rays()
			if(grounded):
				velocity.x=SPEED*direction*1.1
			if(dx<=0):
				if(jump):
					jump=false
					velocity.y=JUMP_VELOCITY
			if(timer.time_left<=0):
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
		$AnimatedSprite2D.flip_h = true
		rc_ground.position= Vector2(x*direction,y) #bad code
	else:
		rc_low.rotation_degrees=0
		rc_high.rotation_degrees=0
		rc_ground.position= Vector2(x,y)
		$AnimatedSprite2D.flip_h = false
func _walk_arround():
	$AnimatedSprite2D.play("Idle")
	dx = abs(global_position.x - last_x)
	if(IdleTimer.time_left<=0.5):
		last_x=global_position.x
		IdleTimer.start(my_random_number)
	velocity.x=SPEED/4*direction
	if(RestTimer.time_left<=0.5|| not grounded):
		if((dx<=0 and stuckTimer.time_left<=0) || not grounded):
			direction=-direction
			_flip_rays()
			stuckTimer.start(0.75)
			RestTimer.start(3)
func _on_hitbox_body_entered(body: Node2D) -> void:
	if dead: return
	if(body.is_in_group("Hazard")):
		call_deferred("_death")
func _death() -> void:
	state=State.Death
	dead=true;
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D2.visible=true
	$AnimatedSprite2D2.play("default")
	await $AnimatedSprite2D2.animation_finished
	queue_free()
func _player_ref(player_reference: CharacterBody2D):
	player=player_reference
func _aggro():
	aggro=true
	state=State.Aggro_Chase
