extends Camera2D

## Nodo marcador para el menu start del juego
@export var initTarget: Marker2D
## Nodo player a seguir
@export var player: CharacterBody2D

## Velocidad de respuesta de la camara
@export var resposne: float = 0.1

func _ready() -> void:
	var hudMainMenu = get_tree().get_first_node_in_group("HUD_MAIN_MENU")
	hudMainMenu.game_start.connect(func ():
		initTarget = null
		)

func _process(_delta: float) -> void:
	if initTarget:
		global_position = lerp(global_position, initTarget.global_position, 0.1)
		return

	# Si existe player:
	if player:
		global_position = lerp(global_position, player.global_position, 0.1)
