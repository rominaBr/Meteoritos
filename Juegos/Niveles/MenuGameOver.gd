extends Node


func _ready() -> void:
	MusicaJuego.play_musica_game_over()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_BotonPrincipal_pressed() -> void:
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Juegos/Niveles/MenuPrincipal.tscn")

