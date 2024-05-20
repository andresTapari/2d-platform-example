extends CharacterBody2D

## Velocidad del personaje
@export var speed: float = 200.0
## Velocidad de salto
@export var jumpVelocity = -400.0


var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")	# Gravedad
var stateMachine																# Maquina de estados	

func _ready() -> void:
	# Cargamos maquina de estado
	stateMachine = $AnimationTree.get("parameters/playback")
	# Reproducimos animación por defecto
	stateMachine.travel("idle")

func _physics_process(delta: float) -> void:
	# Agregamos gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Administramos salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpVelocity

	# actualizamos animaciones
	if velocity.y > 0:
		stateMachine.travel("fall")
	elif velocity.y < 0:
		stateMachine.travel("jump")
	
	# Obtenemos entradas de jugador:
	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	if direction:
		velocity.x = direction * speed
		# Rotamos sprites
		$AnimatedSprite2D.flip_h = velocity.x < 0
		if is_on_floor():
			stateMachine.travel("run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if is_on_floor():
			stateMachine.travel("idle")

	# Movemos el personaje
	move_and_slide()
