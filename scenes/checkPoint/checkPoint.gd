extends Area2D

## Indice del checkpoint
@export var checkpointId: int = 0

## Se emite cuando player entra en el cuerpo
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		LvlData.currentCheckPointIndex = checkpointId
		LvlData.playerCurrentHealth = body.currentHealth
