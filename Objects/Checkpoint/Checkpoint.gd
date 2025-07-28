class_name Checkpoint extends Node2D

@onready var sprite : Sprite2D = $Sprite
@onready var particles : CPUParticles2D = $Particles

const SPEED = 2.0

var collected : bool = false
var initialPos : Vector2 = Vector2(0, 0)
var time : float = 0.0

func _ready() -> void:
	initialPos = position

func _process(delta : float) -> void:
	time += delta
	position.y = initialPos.y + (sin(time * SPEED) * 4)

func UpdateState() -> void:
	if collected:
		sprite.frame = 1
		particles.emitting = false
	else:
		sprite.frame = 0
		particles.emitting = true

func Collect() -> void:
	collected = true
	UpdateState()
	
	var dir = 2 * randi_range(0, 1) - 1
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", deg_to_rad(360 * dir), 0.25)
	tween.set_ease(Tween.EASE_OUT)
	tween.play()

func Reset() -> void:
	collected = false
	UpdateState()

func IsCollected() -> bool:
	return collected
