class_name Camera extends Camera2D

@export var player : Player = null

const START_HEIGHT : int = 90
const VIEWPORT_HEIGHT : int = 180

func _ready() -> void:
	position.y = START_HEIGHT

func _process(delta : float) -> void:
	if player:
		if player.position.y > position.y + VIEWPORT_HEIGHT / 2:
			position.y += VIEWPORT_HEIGHT
		if player.position.y < position.y - VIEWPORT_HEIGHT / 2:
			position.y -= VIEWPORT_HEIGHT
		position.x = player.position.x
