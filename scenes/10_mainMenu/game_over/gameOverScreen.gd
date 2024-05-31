extends Control

## Se ejecuta cuando se presiona el botón restart
func _on_button_restart_pressed():
	get_tree().reload_current_scene()

## Se ejecuta cuando se presiona el botón main menu
func _on_button_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/10_mainMenu/mainMenu.tscn")
	pass # Replace with function body.
