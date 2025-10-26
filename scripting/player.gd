extends CharacterBody2D

@export var teleport:Node2D
@export var scorelabel:CanvasLayer
@export var SPEED = 145.0
@export var JUMP_VELOCITY = -320

const Coyote_Time = 0.1
const Buffer_Time = 0.1
const Snap_Len = 8
var lives = 3

var gargoyle = preload("res://scripting/Enemies/gargoyle.tscn")
var reference = self
var gargoyle_spawned = false
var score = 0


enum State{Idle,Running,Walking,Jumping, Falling}

var state: State=State.Idle
var Coyote_Left = 0
var Buffer_Left = 0
var SpeedMult = 1

signal interact

func _ready() -> void:
	floor_snap_length=Snap_Len


func _physics_process(delta: float) -> void:
	#Timers
	if(is_on_floor()):
		Coyote_Left=Coyote_Time
	else:
		Coyote_Left = max(Coyote_Left - delta, 0.0)
	if(Input.is_action_just_pressed("ui_accept")):
		Buffer_Left = Buffer_Time 
	else:
		Buffer_Left= max(Buffer_Left - delta, 0.0)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("Interact"):
		interact.emit()
	if Input.is_action_just_pressed("Reset"):
		_reset()
	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		state=State.Jumping
	if Input.is_action_pressed("ui_accept") and (Buffer_Left>0 and Coyote_Left >0):
		velocity.y = JUMP_VELOCITY
		Buffer_Left=0
		Coyote_Left=0
		state=State.Jumping
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		state=State.Walking
		if Input.is_action_pressed("Run"):
			SpeedMult= 1.3
			state=State.Running
		else: SpeedMult=1
		velocity.x = direction * SPEED *SpeedMult
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		state=State.Idle
	move_and_slide()
	
	if not is_on_floor() and velocity.y<0.0:
		state=State.Jumping
	elif not is_on_floor() and velocity.y>0.0:
		state=State.Falling
	#Animating
	match state:	
		State.Idle:
			$AnimatedSprite2D.play("Idle")
		State.Walking:
			$AnimatedSprite2D.play("Walking")
			if velocity.x<0:
				$AnimatedSprite2D.flip_h = true
			if velocity.x>0:
				$AnimatedSprite2D.flip_h = false
		State.Jumping:
			$AnimatedSprite2D.play("Jumping")
			if velocity.x<0:
				$AnimatedSprite2D.flip_h = true
			if velocity.x>0:
				$AnimatedSprite2D.flip_h = false
		State.Falling:
			$AnimatedSprite2D.play("Falling")
			if velocity.x<0:
				$AnimatedSprite2D.flip_h = true
			if velocity.x>0:
				$AnimatedSprite2D.flip_h = false
		State.Running:
			$AnimatedSprite2D.play("Runninng")
			if velocity.x<0:
				$AnimatedSprite2D.flip_h = true
			if velocity.x>0:
				$AnimatedSprite2D.flip_h = false
		


func _on_hitbox_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Hazard")||body.is_in_group("Enemy")):
		add_score(-100)
		_reset()
		lives= lives -1

func _reset():
	global_position=teleport.global_position #
	velocity=Vector2.ZERO
	if(lives==0):
		get_tree().reload_current_scene()
func get_score():
	return score
func add_score(amount):
	score += amount
	scorelabel.update_score()
func _set_jump(val:int):
	JUMP_VELOCITY=val
	


func _on_timer_timeout() -> void:
	add_score(-10)
	pass # Replace with function body.
