extends CharacterBody2D

## Velocidad del personaje
@export var speed: float = 200.0
## Velocidad de salto
@export var jumpVelocity = -400.0
## Daño generado
@export var damage = 1

var SWORD = preload(Globals.THROW_SWORD_PATH)


var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")	# Gravedad
var stateMachine																# Maquina de estados	
#var attackEn = false
var groundAttackNames = ["attack_1","attack_2","attack_3"]
var airAttackNames = ["air_attack_1","air_attack_2"]
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
	#if attackEn:
		#return
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpVelocity
	# actualizamos animaciones
	if velocity.y > 0:
		stateMachine.travel("fall")
	elif velocity.y < 0:
		stateMachine.travel("jump")

func handle_movement() -> void:
	#if attackEn:
		#return
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

func handle_attack() -> void:
	if Input.is_action_just_pressed("ui_attack"):
		#attackEn = true
		if is_on_floor():
			stateMachine.travel(groundAttackNames[groundCombo])
			groundCombo = groundCombo + 1 if groundCombo < 2 else 0
		else:
			velocity.y = jumpVelocity / 2
			stateMachine.travel(airAttackNames[airCombo])
			airCombo = airCombo + 1 if airCombo < 1 else 0
	if Input.is_action_just_pressed("ui_throw_sword"):
		stateMachine.travel("throw_sword")

func attack() -> void:
	#attackEn = false
	%RayCast2D.force_raycast_update()
	var collider  = %RayCast2D.get_collider()
	if collider:
		if collider.is_in_group("breackable"):
			collider.hit(damage,%RayCast2D.global_position)

func throw_sword() -> void:
	var new_sword = SWORD.instantiate()
	new_sword.global_position = %Marker2D.global_position
	new_sword.direction.x =  $AnimatedSprite2D.scale.x
	get_tree().current_scene.add_child(new_sword)

