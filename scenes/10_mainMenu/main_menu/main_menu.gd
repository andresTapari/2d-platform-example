extends Control

signal game_start

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeOut":
		game_start.emit()
		queue_free()

func _on_button_start_pressed() -> void:
	%AnimationPlayer.play("fadeOut")
