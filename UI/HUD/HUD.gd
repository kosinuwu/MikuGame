class_name HUD extends Control

@onready var healthBox : HBoxContainer = %HealthBox

func OnPlayerHealthUpdated(health : int) -> void:
	for ball in healthBox.get_children():
		if ball.get_index() < health:
			ball.visible = true
		else:
			ball.visible = false
