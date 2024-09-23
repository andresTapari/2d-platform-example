extends Control

signal restart_lvl

func _ready() -> void:
	%LabelScore.text = str(LvlData.currentScore)



func _on_texture_button_check_point_pressed() -> void:
	restart_lvl.emit()
	queue_free()

func _on_texture_button_main_menu_pressed() -> void:
	LvlData.reset_stats()
	get_tree().reload_current_scene()
