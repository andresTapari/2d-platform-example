extends Control

# Instancia pre-cargada de la pantalla de carga
@onready var LOADING_SCREEN_INSTANCE = preload("res://scenes/10_mainMenu/loadingScreen/loadingScreen.tscn")

var sceneToLoadPath 			# Ruta de la escena a cargar
var loadingSceneScreenInstance  # Instancia de la pantalla de carga
var loading = false  			# Bandera para indicar si se está cargando

# Función para cargar una nueva escena
func load_scene(path):
	var currentScene = get_tree().current_scene
	
	# Instanciar y agregar la pantalla de carga como hijo diferido al árbol
	loadingSceneScreenInstance = LOADING_SCREEN_INSTANCE.instantiate()
	loadingSceneScreenInstance.playerReady.connect(_handle_loading_screen_player_ready)
	get_tree().root.call_deferred("add_child", loadingSceneScreenInstance)
	
	# Verificar si la escena está en caché
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)
	
	currentScene.queue_free()
	
	loading = true
	sceneToLoadPath = path

# Función _process(delta) para manejar el progreso de carga
func _process(_delta):
	if not loading:
		# Salir si no se está cargando
		return
	var progress: Array = []
	var status = ResourceLoader.load_threaded_get_status(sceneToLoadPath,progress)
	
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		loadingSceneScreenInstance.update_progress(progress[0])
	
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		# Atravez de la pantalla de carga informa que debe precionar una tecla
		# para continuar
		loadingSceneScreenInstance.set_ready()
		loadingSceneScreenInstance.update_progress(100)
		loading = false
	else:
		# Informa errores de carga
		push_error("ERROR CARGANDO ESCENA:",sceneToLoadPath)


func _handle_loading_screen_player_ready():
	# Cambiar a la nueva escena, liberar la pantalla de carga y desactivar la bandera de carga
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(sceneToLoadPath))
	loadingSceneScreenInstance.queue_free()
