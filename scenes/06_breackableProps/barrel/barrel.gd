extends RigidBody2D

## Vida de la caja
@export var health: 	int = 3
## Fuerza de salto cuando es golpeado
@export var jumpForce: 	int = 100

var currentHealth = health

## 
func hit(incomeDamage: int, incomeDamagePosition: Vector2 = Vector2.ZERO) -> void:
	# Descontar vida
	currentHealth -= incomeDamage
	if currentHealth <= 0:
		for parts in %Parts.get_children():
			var dir : Vector2 = (global_position - incomeDamagePosition).normalized()
			var impulse: Vector2 = Vector2(dir.x , -1) * jumpForce
			parts.freeze = false
			parts.visible = true
			parts.apply_impulse(impulse)
			parts.get_node("Timer").start()
			parts.reparent(get_tree().current_scene)
		%AnimatedSprite2D.visible = false
		queue_free()

	# Aplicamos impulso
	var dir : Vector2 = (global_position - incomeDamagePosition).normalized()
	var impulse: Vector2 = Vector2(dir.x , -1) * jumpForce
	apply_impulse(impulse)

	# Actualizamos animacion
	%AnimatedSprite2D.play("hit")
	%AnimatedSprite2D.animation_finished.connect(func (): 
		%AnimatedSprite2D.play("idle"))
