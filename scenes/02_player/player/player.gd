extends CharacterBody2D

## Velocidad del personaje
@export var speed: float = 200.0
## Velocidad de salto
@export var jumpVelocity = -400.0


var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")	# Gravedad
var stateMachine																# Maquina de estados	
var attackEn = false
var groundCombo = 0
var airCombo 	= 0

func _ready() -> void:
	# Cargamos maquina de estado
	stateMachine = $AnimationTree.get("parameters/playback")
	# Reproducimos animación por defecto
	stateMachine.travel("idle")

func _physics_process(delta: float) -> void:
	# Agregamos gravedad
	apply_gravity(delta)

	# Administramos salto
	handle_jump()
	
	# Administramos movimientos
	handle_movement()
	
	# Administramos ataque
	handle_attack()

	# Movemos el personaje
	move_and_slide()

func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump() -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpVelocity
	# actualizamos animaciones
	if velocity.y > 0:
		stateMachine.travel("fall")
	elif velocity.y < 0:
		stateMachine.travel("jump")

func handle_movement() -> void:
	if attackEn:
		return
	# Obtenemos entradas de movimiento del jugador:
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

func handle_attack() -> void:
	if Input.is_action_just_pressed("ui_attack"):
		attackEn = true
		%ComboTimer.start()
		if not %ComboTimer.is_stopped():
			groundCombo += 1
		if is_on_floor():
			#groundAttackCounter += 1
			match groundCombo:
				1:
					stateMachine.travel("attack_1")
				2:
					stateMachine.travel("attack_2")
				3:
					stateMachine.travel("attack_3")
		#else:
			#airAttackCounter += 1
			#match airAttackCounter:
				#1:
					#stateMachine.travel("air_attack_1")
				#2:
					#stateMachine.travel("air_attack_2")
	#
			#velocity.y = jumpVelocity/2

func attack() -> void:

	print("Attack")
	attackEn = false
	pass


func _on_animation_tree_animation_finished(anim_name):
	pass # Replace with function body.
