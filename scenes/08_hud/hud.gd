extends CanvasLayer

## Señal que se emite cuando se crea ventana de 'game_over'
signal game_over_dlg_show_up(dlg)

## Escenas precargadas
@onready var SETUP_DLG = preload(Globals.SETUP_WINDOW_PATH)
@onready var GAME_OVER_SCREEN = preload(Globals.GAME_OVER_SCREEN_PATH)
@onready var WIN_SCREEN = preload(Globals.END_LEVEL_1_PATH)

@export var tutorialsContainer: Node2D
@export var player: CharacterBody2D
 
func _ready():
	visible = true
	
	# Conectamos señales de player
	player = get_tree().get_first_node_in_group("player")
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
	
	# Conectamos señales de evento win
	var winItem: Array = get_tree().get_nodes_in_group("win_item")
	if winItem.size() > 0:
		winItem[0].end_lvl_event.connect(handle_win_event)

func _on_main_menu_game_start() -> void:
	%healthBar.visible = true
	if tutorialsContainer:
		tutorialsContainer.visible = true
	if player:
		player.ingnoreInputEn = false

func handle_win_event() -> void:
	# Borramos todos los elementos de la pantalla
	for controls in get_children():
		controls.queue_free()

	# Mostramos pantalla de victoria y cerramos el juego
	var winDlg = WIN_SCREEN.instantiate()
	add_child(winDlg)
	get_tree().paused = true 


func _on_menu_button_pressed() -> void:
	var newDlg = SETUP_DLG.instantiate()
	add_child(newDlg)
