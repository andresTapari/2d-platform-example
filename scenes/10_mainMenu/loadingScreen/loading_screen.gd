extends Control


## Señal que se emite cuando se presiona una tecla
signal playerReady

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		if %ProgressBar.value == 100:
			playerReady.emit()

func set_ready() -> void:
	$AnimatedSprite2D.visible =false
	%Label.text = "Presione una tecla para iniciar."


## Actualiza la barra de carga
func update_progress(newProgress)  -> void:
	%ProgressBar.value = newProgress * 100
