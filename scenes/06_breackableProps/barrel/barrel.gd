extends RigidBody2D

## Vida de la caja
@export var health: 	int = 2
## Fuerza de salto cuando es golpeado
@export var jumpForce: 	int = 100

## Partes del barril
@onready var BARREL_PARTS = preload(Globals.BARREL_PARTS_TSCN)
@onready var POTION = preload(Globals.POTION_TSCN)

var currentHealth = health	# Vida del barril

## provoca daño al barril, resta vida y lo impulsa en direccion opuesta al origen del daño
func hit(incomeDamage: int, incomeDamagePosition: Vector2 = Vector2.ZERO) -> void:
	# Calculamos Impulso
	var dir : Vector2 = (global_position - incomeDamagePosition).normalized()
	var impulse: Vector2 = Vector2(dir.x , -1) * jumpForce
	# Descontar vida
	currentHealth -= incomeDamage
	apply_impulse(impulse)
	
	# Actualizamos animacion
	%AnimatedSprite2D.play("hit")
	$soundFx/hurt.play()
	
	# Evaluamos vida actual
	if currentHealth <= 0:
		$soundFx/explosion.play()
		$soundFx/explosion.finished.connect(func (): call_deferred("queue_free"))
		%AnimatedSprite2D.visible = false
		for n in range(4):
			spawn_parts(n)
		spawn_drop()
	# Esperamos que la animacion termine
	await %AnimatedSprite2D.animation_finished
	%AnimatedSprite2D.play("idle")

## Crea partes del barril
func spawn_parts(counter: int):
	# Crea instancia
	var newPart:BarrelPart = BARREL_PARTS.instantiate()
	get_parent().add_child(newPart)
	
	# Establece posicion
	newPart.global_position = self.global_position
	newPart.spriteFrame = counter
	
	# Determina direccion del impulso segun el frame, 0: (1,-1), 1:(-1,-1), 2:(1,0), 3(-1,0) 
	var newImpulse = Vector2(jumpForce,-jumpForce) if counter%2 else Vector2(-jumpForce,-jumpForce)
	if counter>1:
		newImpulse.y = 0
	
	# Aplica el impuslo
	newPart.apply_impulse(newImpulse * 1.5)

## Crea una pocion en el lugar donde esta el barril dentro del nivel
func spawn_drop():
	# Crea una instancia, la agrega al nivel y establece su posicion inicial
	var drop = POTION.instantiate()
	get_parent().add_child(drop)
	drop.global_position = self.global_position
