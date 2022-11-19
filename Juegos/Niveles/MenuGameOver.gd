extends Node


func _ready() -> void:
	MusicaJuego.play_musica_game_over()


func _on_BotonPrincipal_pressed() -> void:
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Juegos/Niveles/MenuPrincipal.tscn")

