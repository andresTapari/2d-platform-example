extends Camera2D

## Nodo player
@export var player: CharacterBody2D
## Velocidad de respuesta de la camara
@export var resposne: float = 0.1

func _process(delta: float) -> void:
	# Si existe player:
	if player:
		global_position = lerp(global_position, player.global_position, 0.1)
