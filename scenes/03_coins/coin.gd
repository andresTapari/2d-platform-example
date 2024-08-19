extends Area2D

signal picked(score)

## Puntaje de la moneta
@export var score = 1

## Se ejecuta cuando un cuerpo entra en el área de detección de la moneda
func _on_body_entered(body):
	# Si body pertenece al grupo player
	if body.is_in_group("player"):
		# Emitimos señal que se recolecto una moneda
		picked.emit(score)
		# Reproducimos animación
		$AnimatedSprite2D.play("picked")
		$AudioStreamPlayer.play()
		# Conectamos señal que termina animación para eliminar la moneda
		$AnimatedSprite2D.animation_finished.connect(func (): queue_free())
