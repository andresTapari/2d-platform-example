extends Area2D

var dirX = 1
var speed = 250
var damage = 5

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += dirX * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("lvl"):
		speed = 0
		$AnimatedSprite2D.play("explosion")
		$AudioStreamPlayer2D.play()
		if body.is_in_group("player"):
			body.hurt(damage,self.global_position)

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "explosion":
		queue_free()


func _on_animated_sprite_2d_animation_changed() -> void:
	if $AnimatedSprite2D.animation == "explosion":
		$CollisionShape2D.set_deferred("disabled",true)
