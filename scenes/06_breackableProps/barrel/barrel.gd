extends RigidBody2D

## Vida de la caja
@export var health: 	int = 3
## Fuerza de salto cuando es golpeado
@export var jumpForce: 	int = 100

## Partes del barril
@onready var BARREL_PARTS = preload(Globals.BARREL_PARTS_TSCN)

var currentHealth = health	# Vida del barril

## Ejecutar función de 
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
			var newPart:BarrelPart = BARREL_PARTS.instantiate()
			get_parent().add_child(newPart)
			newPart.global_position = self.global_position
			newPart.spriteFrame = n
			var newImpulse = Vector2(jumpForce,-jumpForce) if n%2 else Vector2(-jumpForce,-jumpForce)
			if n>1:
				newImpulse.y = 0
			newPart.apply_impulse(newImpulse * 1.5)
	
	# Esperamos que la animacion termine
	await %AnimatedSprite2D.animation_finished
	%AnimatedSprite2D.play("idle")
