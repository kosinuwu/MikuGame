class_name Player extends CharacterBody2D

signal healthUpdated(health : int)

@onready var jumpBuffer = $JumpBuffer
@onready var coyoteTime = $CoyoteTime

const SPEED : int = 800
const MAX_SPEED : int = 250
const FRICTION : int = 250
const GRAVITY : int = 840
const JUMP : int = -300
const BOUNCE : float = 0.7
const JUMP_BUFFER_TIME : float = 0.15
const COYOTE_TIME : float = 0.08

var health : int = 5
var lastVelocity : Vector2 = Vector2(0, 0)
var inAir : bool = false
var levelStart : Vector2 = Vector2(0, 0)
var checkpoint : Checkpoint = null

func _ready() -> void:
	levelStart = position

func _process(delta : float) -> void:
	#Horizontal Movement
	var dir : int = Input.get_axis("LEFT", "RIGHT")
	velocity.x += dir * SPEED * delta
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	if is_on_wall():
		velocity.x = -lastVelocity.x * BOUNCE
	
	#Vertical Movement
	velocity.y += GRAVITY * delta
	
	if is_on_floor():
		if lastVelocity.y > 40:
			velocity.y = -lastVelocity.y * BOUNCE
		if inAir:
			inAir = false
	else:
		if not inAir:
			inAir = true
			coyoteTime.start(COYOTE_TIME)
	
	if Input.is_action_pressed("UP"):
		jumpBuffer.start(JUMP_BUFFER_TIME)
	
	if not jumpBuffer.is_stopped():
		if is_on_floor() or not coyoteTime.is_stopped():
			velocity.y = JUMP
	
	lastVelocity = velocity
	move_and_slide()

func OnHitboxAreaEntered(_area : Area2D) -> void:
	health -= 1
	healthUpdated.emit(health)
	if health <= 0:
		get_tree().reload_current_scene()
		return
	if checkpoint != null:
		velocity = Vector2.ZERO
		position = checkpoint.position
	else:
		velocity = Vector2.ZERO
		position = levelStart

func OnCheckpointAreaAreaEntered(area : Area2D) -> void:
	var check : Checkpoint = area.owner
	if not check.IsCollected():
		check.Collect()
		checkpoint = check
