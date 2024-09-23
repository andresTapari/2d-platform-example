@tool
extends Area2D

## Mensaje a mostrar
@export var text: String :
	set(value):
		text = value
		%LabelMessage.text = value	#<- establecemos texto en el label

func _ready() -> void:
	# Cuando se crea, se pone invisible con su canal 'ALFA'
	%LabelMessage.modulate = Color(1,1,1,0)

## Se ejecuta cuando un cuerpo entra en su area de deteccion
func _on_body_entered(body: Node2D) -> void:
	# Si el cuerpo es del grupo player
	if body.is_in_group("player"):
		# Reproducimos animacion
		$AnimationPlayer.play("fadeIn")

## Se ejecuta cuando un cuerpo sale de su area de deteccion
func _on_body_exited(body: Node2D) -> void:
	# Si el cuerpo es del grupo player
	if body.is_in_group("player"):
		# Reproducimos animacion
		$AnimationPlayer.play("fadeOut")
