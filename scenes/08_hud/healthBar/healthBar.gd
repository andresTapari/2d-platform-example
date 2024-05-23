extends TextureRect

## Actualiza el valor de la barra de vida
func update_value(value: int, maxValue: int) -> void:
	%TextureProgressBar.max_value 	= maxValue
	%TextureProgressBar.value 		= value
