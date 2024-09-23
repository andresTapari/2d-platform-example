extends Control

## Se ejecuta cuando se presiona el bot
func _on_texture_button_pressed() -> void:
	LvlData.reset_stats()
	get_tree().paused = false
	get_tree().reload_current_scene()
