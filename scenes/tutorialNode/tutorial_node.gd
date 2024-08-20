@tool
extends Area2D

@export var text: String :
	set(value):
		text = value
		%LabelMessage.text = value

func _ready() -> void:
	%LabelMessage.modulate = Color(1,1,1,0)

func _on_body_entered(body: Node2D) -> void:
	$AnimationPlayer.play("fadeIn")

func _on_body_exited(body: Node2D) -> void:
	$AnimationPlayer.play("fadeOut")
