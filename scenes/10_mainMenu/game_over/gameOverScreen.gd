extends Control

signal restart_lvl

func _ready() -> void:
	%LabelScore.text = str(LvlData.currentScore)

## Se ejecuta cuando se presiona el botón restart
func _on_button_restart_pressed():
	restart_lvl.emit()
	queue_free()

## Se ejecuta cuando se presiona el botón main menu
func _on_button_main_menu_pressed():
	# restart game data:
	LvlData.reset_stats()
	get_tree().reload_current_scene()
