@tool
extends Area2D

@onready var CANNON_BALL = preload("res://scenes/11_enemey/cannon_ball.tscn")

## Rota la dirección de apuntado del cañon
@export var flip_h: bool :
	set(value):
		flip_h = value
		$AnimatedSprite2D.scale.x = -1 if flip_h else 1

## Tiempo a esperar para el proximo disparo
@export var wait_time: float: 
	set(value):
		wait_time = value
		$Timer.wait_time = value

## El nodo se activa cuando aparece en pantalla, si es falso siempre esta activo
@export var visibleOnScreenEnabelrEn: bool = true


func _ready() -> void:
	# Si puede disparar fuera de la pantalla
	if not visibleOnScreenEnabelrEn:
		# Elimnamos el nodo de habilitar en pantalla
		$VisibleOnScreenEnabler2D.queue_free()
		# Establecemos el modo de proceso normal
		process_mode = PROCESS_MODE_INHERIT

## Dispara una bala de cañon
func shoot() -> void:
	# Crea una instancia
	var newCannonBall = CANNON_BALL.instantiate()
	# La agrega al nivel
	get_tree().get_first_node_in_group("current_lvl").add_child(newCannonBall)
	# Establece la posicion y la direcci
	newCannonBall.dirX = 1 if flip_h else -1
	newCannonBall.global_position = %Marker2D.global_position

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("fire")

func reset_animation_player() -> void:
	$AnimationPlayer.play("idle")
