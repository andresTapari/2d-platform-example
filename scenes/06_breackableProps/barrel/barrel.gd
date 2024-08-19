extends RigidBody2D

## Vida de la caja
@export var health: 	int = 3
## Fuerza de salto cuando es golpeado
@export var jumpForce: 	int = 100

var currentHealth = health

## 
func hit(incomeDamage: int, incomeDamagePosition: Vector2 = Vector2.ZERO) -> void:
	# Calculamos Impulso
	var dir : Vector2 = (global_position - incomeDamagePosition).normalized()
	var impulse: Vector2 = Vector2(dir.x , -1) * jumpForce
	# Descontar vida
	currentHealth -= incomeDamage
	if currentHealth <= 0:
		$soundFx/explosion.play()
		for parts in %Parts.get_children():
			parts.set_deferred("freeze",false)
			parts.visible = true
			parts.get_node("Timer").start()
			parts.call_deferred("reparent",get_tree().current_scene)
			parts.call_deferred("apply_impulse",impulse)
		
		%AnimatedSprite2D.visible = false
		$soundFx/explosion.finished.connect(func (): 
			queue_free()
			)
		
	else:
		$soundFx/hurt.play()
	apply_impulse(impulse)

	# Actualizamos animacion
	%AnimatedSprite2D.play("hit")
	%AnimatedSprite2D.animation_finished.connect(func (): 
		%AnimatedSprite2D.play("idle"))
