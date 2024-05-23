extends CharacterBody2D

##Señales:
signal health_changed(currentHealth, maxHealth)

## Velocidad del personaje
@export var speed: float = 200.0
## Velocidad de salto
@export var jumpVelocity = -400.0
## Daño generado
@export var damage = 1
## Vida del personaje
@export var maxHealth = 10

## Escenas precargadas
var SWORD = preload(Globals.THROW_SWORD_PATH)

## Variables
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")	# Gravedad
var stateMachine																# Maquina de estados
var groundAttackNames 	: Array = ["attack_1","attack_2","attack_3"]			# Lista de nombres con las animaciones de ataque terrestre
var airAttackNames 		: Array = ["air_attack_1","air_attack_2"]				# Lista de nombres con las animaciones de ataque aereo
var groundAtackCounter 	: int = 0												# Contador de ataque terrestre
var airAtackCounter 	: int = 0												# Contador de ataque aereo
var currentHealth		: int = maxHealth

func _ready() -> void:
	# Cargamos maquina de estado
	stateMachine = $AnimationTree.get("parameters/playback")
	# Reproducimos animación por defecto
	stateMachine.travel("idle")
	# Actualizamos vida
	health_changed.emit(currentHealth,maxHealth)
	
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

## Aplica gravedad al personaje
func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

## Administra el salto y la caida
func handle_jump() -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpVelocity
	# actualizamos animaciones
	if velocity.y > 0:
		stateMachine.travel("fall")
	elif velocity.y < 0:
		stateMachine.travel("jump")

## Administra el movimiento
func handle_movement() -> void:
	# Obtenemos entradas de movimiento del jugador:
	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	if direction:
		velocity.x = direction * speed
		# Rotamos sprites
		$AnimatedSprite2D.scale.x = 1 if velocity.x > 0 else -1
		if is_on_floor():
			stateMachine.travel("run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if is_on_floor():
			stateMachine.travel("idle")

## Administra el ataque
func handle_attack() -> void:
	if Input.is_action_just_pressed("ui_attack"):
		# Si esta en el piso
		if is_on_floor():
			stateMachine.travel(groundAttackNames[groundAtackCounter])
			groundAtackCounter = groundAtackCounter + 1 if groundAtackCounter < 2 else 0
		# Si esta en el aire
		else:
			velocity.y = jumpVelocity / 2
			stateMachine.travel(airAttackNames[airAtackCounter])
			airAtackCounter = airAtackCounter + 1 if airAtackCounter < 1 else 0
	# Si se presiona para arrojar espada
	if Input.is_action_just_pressed("ui_throw_sword"):
		stateMachine.travel("throw_sword")

## Ejecuta el ataque
func attack() -> void:
	# Actualizamos raycast y obtenemos colisiones
	%RayCast2D.force_raycast_update()
	var collider  = %RayCast2D.get_collider()
	if collider:
		# Si las colisiones son del grupo "breackable"
		if collider.is_in_group("breackable"):
			collider.hit(damage,%RayCast2D.global_position)

## Arroja la espada
func throw_sword() -> void:
	var new_sword = SWORD.instantiate()
	new_sword.global_position = %Marker2D.global_position
	new_sword.direction.x =  $AnimatedSprite2D.scale.x
	get_tree().current_scene.add_child(new_sword)
