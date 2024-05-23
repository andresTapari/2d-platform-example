extends CanvasLayer


func _ready():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.health_changed.connect(func (currentHealth, maxHealth):
			%healthBar.update_value(currentHealth,maxHealth)
			)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
