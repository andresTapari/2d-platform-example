extends TabBar

# Variables para almacenar los valores iniciales
var initial_master_volume_db: float
var initial_music_volume_db: float
var initial_soundfx_volume_db: float

var initial_master_mute: bool
var initial_music_mute: bool
var initial_soundfx_mute: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Cargamos valos actuales
	initial_master_volume_db  = db_to_slider_value(AudioServer.get_bus_volume_db(Globals.MASTER_BUS_INDEX))
	initial_music_volume_db   = db_to_slider_value(AudioServer.get_bus_volume_db(Globals.MUSIC_BUS_INDEX))
	initial_soundfx_volume_db = db_to_slider_value(AudioServer.get_bus_volume_db(Globals.SOUNDFX_BUS_INDEX))

	initial_master_mute  = not AudioServer.is_bus_mute(Globals.MASTER_BUS_INDEX)
	initial_music_mute   = not AudioServer.is_bus_mute(Globals.MUSIC_BUS_INDEX)
	initial_soundfx_mute = not AudioServer.is_bus_mute(Globals.SOUNDFX_BUS_INDEX)
	
	#Iniciamos estado actual del Audio Server
	%CheckButtonMasterEn.button_pressed = initial_master_mute
	%CheckButtonMusicEn.button_pressed  = initial_music_mute
	%CheckButtonFxEn.button_pressed     = initial_soundfx_mute
	
	%HSliderMaster.value  = initial_master_volume_db
	%HSliderMusic.value   = initial_music_volume_db
	%HSliderSoundFx.value = initial_soundfx_volume_db

## Convierte dB a un valor entre 0 y 100 para el slider
func db_to_slider_value(db: float) -> float:
	var min_db = -72.0  # El valor mínimo en dB (puede ser ajustado según tus necesidades)
	var max_db = 0.0    # El valor máximo en dB
	return clamp(100 * (db - min_db) / (max_db - min_db), 0, 100)

## Convierte un valor del slider (0 a 100) a dB
func slider_value_to_db(slider_value: float) -> float:
	var min_db = -72.0  # El valor mínimo en dB (puede ser ajustado según tus necesidades)
	var max_db = 0.0    # El valor máximo en dB
	return lerp(min_db, max_db, slider_value / 100.0)


## Desache los cambios
func undo_changes() -> void:
	pass

func _on_check_button_master_en_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(Globals.MASTER_BUS_INDEX,not toggled_on)

func _on_h_slider_master_value_changed(value: float) -> void:
	pass # Replace with function body.

func _on_check_button_music_en_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(Globals.MUSIC_BUS_INDEX,not toggled_on)

func _on_h_slider_music_changed() -> void:
	pass # Replace with function body.

func _on_check_button_fx_en_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(Globals.MUSIC_BUS_INDEX,not toggled_on)


func _on_h_slider_sound_fx_changed() -> void:
	pass # Replace with function body.
