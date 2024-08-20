extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneLoader.load_scene("res://scenes/01_lvl/01_lvl.tscn")
