extends CanvasLayer


func _ready():
	# Conectamos señales de player
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.health_changed.connect(func (currentHealth, maxHealth):
			%healthBar.update_value(currentHealth,maxHealth)
			)

	# Conectamos señales de monedas
	var coins = get_tree().get_nodes_in_group("pickable")
	for coin in coins:
		coin.picked.connect(func (score):
			%coinCounter.update_value(score)
			)
