extends Control

signal playerReady

@export var changeSceneOnLoad: bool = true
@export var animateEn: bool = true

var currentProgress: int = 0
var targetProgress: int = 0

func _input(event: InputEvent) -> void:
	if event.is_pressed() and targetProgress == 100:
		playerReady.emit()

## Actualiza la barra de carga con animación
func update_progress(newProgress: float) -> void:
	# Si no cambio el progreso sale.
	if targetProgress == newProgress:
		return
	targetProgress = newProgress
	
	if not animateEn:
		%TextureProgressBar.value = targetProgress
		if targetProgress > 100:
			set_ready()
			if changeSceneOnLoad:
				playerReady.emit()
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(%TextureProgressBar, "value", targetProgress, 1)
		tween.finished.connect(func ():
			if targetProgress >= 100:
				set_ready()
				if changeSceneOnLoad:
					playerReady.emit()
			)

func set_ready()-> void:
	$AnimatedSprite2D.visible = false
	%Label.visible = !changeSceneOnLoad
	%Label.text = "Presione una tecla para iniciar."
