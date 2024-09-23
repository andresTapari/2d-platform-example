extends Area2D

## Cantidad de puntos de vida que reestablece
@export var healthAmount : int = 2

## Se ejecuta cuando un cuerpo entra en el area de deteccion
func _on_body_entered(body: Node2D) -> void:
	# Si el cuerpo pertenece a player
	if body.is_in_group("player"):
		# Casteamos body como player
		var player = body as Player
		player.heal(healthAmount)
		
		# Reproducimos animacion y esperamos a que termine
		$AnimatedSprite2D.play("picked")
		await  $AnimatedSprite2D.animation_finished
		
		# Eliminamos nodo
		queue_free()
