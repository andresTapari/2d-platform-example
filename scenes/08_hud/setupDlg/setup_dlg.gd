extends Window

func _ready() -> void:
	# pausamos juego
	get_tree().paused = true

func close_window() -> void:
	get_tree().paused = false
	queue_free()

func _on_button_aceptar_pressed() -> void:
	close_window()

func _on_button_cancelar_pressed() -> void:
	%Audio.undo_changes()
	close_window()

func _on_focus_exited() -> void:
	close_window()

func _on_close_requested() -> void:
	close_window()
