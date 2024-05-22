@tool
extends AnimatedSprite2D

@export_enum("big","small") var currentAnimation = "big":
	set(value):
		currentAnimation = value
		play(currentAnimation)

# Called when the node enters the scene tree for the first time.
func _ready():
	play(currentAnimation)
