class_name Camera extends Camera2D

@export var player : Player = null
@export var minX : int = 0
@export var maxX : int = 0

const START_HEIGHT : int = 90
const VIEWPORT_HEIGHT : int = 180

func _ready() -> void:
	position.y = START_HEIGHT

func _process(_delta : float) -> void:
	if player:
		if player.position.y > position.y + VIEWPORT_HEIGHT / 2:
			position.y += VIEWPORT_HEIGHT
		if player.position.y < position.y - VIEWPORT_HEIGHT / 2:
			position.y -= VIEWPORT_HEIGHT
		position.x = player.position.x
	position.x = clamp(position.x, minX, maxX)
