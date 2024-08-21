extends Area2D

## Evento de fin del nivel
signal end_lvl_event

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		end_lvl_event.emit()
