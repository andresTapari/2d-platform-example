extends Area2D

signal win_event

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		win_event.emit()
