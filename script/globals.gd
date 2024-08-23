extends Node

# Hud:
## Ventana de configuración:
const SETUP_WINDOW_PATH: String = "res://scenes/08_hud/setupDlg/setupDlg.tscn"

## Pantalla de 'Game Over':
const GAME_OVER_SCREEN_PATH: String = "res://scenes/10_mainMenu/game_over/gameOverScreen.tscn"

## Pantalla de 'Fin del nivel':
const END_LEVEL_1_PATH: String = "res://scenes/10_mainMenu/win_screen/win_screen.tscn"

# Entities:
## Projectil espada:
const THROW_SWORD_TSCN: String = "res://scenes/07_projectile/throwSword/throwSword.tscn"

## Partes del barril:
const BARREL_PARTS_TSCN: String = "res://scenes/06_breackableProps/barrel/barrelPart.tscn"

## Posion de curación:
const POTION_TSCN: String = "res://scenes/potion/potion.tscn"


## Bus audio master:
const MASTER_BUS_INDEX: int = 0
## Bus audio música
const MUSIC_BUS_INDEX: int = 1
## Bus audio efectos
const SOUNDFX_BUS_INDEX: int = 2
