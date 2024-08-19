@tool
extends Area2D

@onready var CANNON_BALL = preload("res://scenes/11_enemey/cannon_ball.tscn")


@export var flip_h: bool :
	set(value):
		flip_h = value
		$AnimatedSprite2D.scale.x = -1 if flip_h else 1
@export var wait_time: float: 
	set(value):
		wait_time = value
		$Timer.wait_time = value

func shoot() -> void:
	var newCannonBall = CANNON_BALL.instantiate()
	get_tree().get_first_node_in_group("current_lvl").add_child(newCannonBall)
	newCannonBall.dirX = 1 if flip_h else -1
	newCannonBall.global_position = %Marker2D.global_position

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("fire")

func reset_animation_player() -> void:
	$AnimationPlayer.play("idle")
