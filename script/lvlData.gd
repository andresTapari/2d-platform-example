extends Node

## Id del checkpoint actual
var currentCheckPointIndex: int = 0:
	set(value):
		if value > currentCheckPointIndex or value == 0:
			currentCheckPointIndex = value

## Vida de player en este checkpoint
var playerCurrentHealth: int = 10

var currentScore: int = 0


func reset_stats() -> void:
	currentCheckPointIndex = 0
	currentScore = 0
