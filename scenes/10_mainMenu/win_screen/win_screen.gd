extends Control

func _on_button_pressed() -> void:
	LvlData.reset_stats()
	get_tree().paused = false
	get_tree().reload_current_scene()
