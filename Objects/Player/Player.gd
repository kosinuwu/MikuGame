class_name Player extends RigidBody2D

const SPEED : int = 150
const JUMP : int = -250

func _process(delta : float) -> void:
	var dir : int = Input.get_axis("LEFT", "RIGHT")
	apply_force(Vector2(dir * SPEED, 0))
	if Input.is_action_just_pressed("UP"):
		linear_velocity.y = JUMP
