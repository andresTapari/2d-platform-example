extends CanvasLayer

## Señal que se emite cuando se crea ventana de 'game_over'
signal game_over_dlg_show_up(dlg)

## Escenas precargadast
@onready var GAME_OVER_SCREEN = preload("res://scenes/10_mainMenu/game_over/gameOverScreen.tscn")

@export var tutorialsContainer: Node2D
@export var player: CharacterBody2D
 
func _ready():
	# Conectamos señales de player
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.health_changed.connect(func (currentHealth, maxHealth):
			%healthBar.update_value(currentHealth,maxHealth)
			)
		player.game_over.connect(func ():
			var newDlg = GAME_OVER_SCREEN.instantiate()
			add_child(newDlg)
			%healthBar.visible = false
			game_over_dlg_show_up.emit(newDlg)
			newDlg.restart_lvl.connect(func():
				%healthBar.visible = true
				)
			)
	# Conectamos señales de monedas
	var coins = get_tree().get_nodes_in_group("pickable")
	for coin in coins:
		coin.picked.connect(func (score):
			LvlData.currentScore += score 
			%coinCounter.update_value(score)
			
			)
	## Desactiva el menu principal
	#if dontShowMainMenuEn:
		#$MainMenu.queue_free()
		#$MainMenu.game_start.emit()

func _on_main_menu_game_start() -> void:
	%healthBar.visible = true
	if tutorialsContainer:
		tutorialsContainer.visible = true
	if player:
		player.ingnoreInputEn = false
