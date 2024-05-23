extends HBoxContainer

var currentScore:  int = 0					# Puntaje actual
var numberOfZeros: int = 4					# Cantidad de zeros

## Actualiza el valor del contador de monedas
func update_value(value: int) -> void:
	currentScore += value
	var text: String = str(currentScore)
	var score: = ""
	for n in range(numberOfZeros - text.length()): 
		score += "0"
	score += text
	%Label.text = str(score)
