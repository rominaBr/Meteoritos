extends Node

## Atributos
var player_actual:Player = null setget set_player_actual, get_player_actual
var vidas:int = 3
var nivel_actual = ""

## Setters y getters
func set_player_actual(player:Player) -> void:
	player_actual = player

func restar_vidas():
	vidas -= 1	
	if vidas == 0:
		Eventos.emit_signal("game_over")		
	Eventos.emit_signal("actualizar_vidas")

func get_player_actual() -> Player:
	return player_actual
	
func _ready() -> void:
	Eventos.connect("nave_destruida", self, "_on_nave_destruida")
	
func _on_nave_destruida(nave: NaveBase, _posicion, _explosiones) -> void:
	if nave is Player:
		player_actual = null
