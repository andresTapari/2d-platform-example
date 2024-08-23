extends Area2D

@export var healthAmount : int = 2



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player = body as Player
		player.heal(healthAmount)
		$AnimatedSprite2D.play("picked")
		await  $AnimatedSprite2D.animation_finished
		queue_free()
