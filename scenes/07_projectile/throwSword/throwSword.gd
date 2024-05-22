extends Area2D

## Velocidad de movimiento 
@export var speed: int = 250
## Daño
@export var damage: int = 1

var direction : Vector2 = Vector2.ZERO:
	set(value):
		direction = value
		$AnimatedSprite2D.scale.x = direction.x


func _process(delta):
	position.x += direction.x * delta * speed


func _on_body_entered(body):
	if body.is_in_group("breackable"):
		body.hit(damage, global_position)
		queue_free()
