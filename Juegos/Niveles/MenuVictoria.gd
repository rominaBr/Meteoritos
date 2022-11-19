extends Node

export(String, FILE, "*.tscn") var menu_principal = ""

func _ready() -> void:
	$AnimationPlayer.play("volar")
	$AnimationGanaste.play("ganaste")
	MusicaJuego.play_musica_victoria()


func _on_BotonMenu_pressed() -> void:
	get_tree().change_scene(menu_principal)


func _on_BotonSalir_pressed() -> void:
	get_tree().quit()
