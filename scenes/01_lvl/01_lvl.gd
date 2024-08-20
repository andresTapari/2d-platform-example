extends Node2D


func _handle_player_entered_check_point(id: int) -> void:
	if id > LvlData.currentCheckPointIndex:
		LvlData.currentCheckPointIndex = id
		LvlData.playerCurrentHealth

## Esto cambiar
func _on_hud_game_over_dlg_show_up(dlg: Variant) -> void:
	dlg.restart_lvl.connect(func ():
		if LvlData.currentCheckPointIndex > 0:
			for checkPoint in get_tree().get_nodes_in_group("check_point"):
				if checkPoint.checkpointId == LvlData.currentCheckPointIndex:
					var camera = get_tree().get_first_node_in_group("camera")
					camera.global_position = checkPoint.global_position
					var player = get_tree().get_first_node_in_group("player")
					player.global_position = checkPoint.global_position
					player.reset_stats()
		)
