extends Area2D

@export var damage: int = 2

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(damage,global_position)
