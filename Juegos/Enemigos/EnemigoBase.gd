class_name EnemigoBase
extends NaveBase

## Atributos
var player_objetivo:Player = null

## Métodos
func _ready() -> void:
	player_objetivo = DatosJuego.get_player_actual()
	print(player_objetivo)
	Eventos.connect("nave_destruida", self, "_on_nave_destruida")
	canion.set_esta_disparando(true)

func _physics_process(delta: float) -> void:
	rotar_hacia_player()

## Métodos custom
func _on_nave_destruida(nave: NaveBase, _posicion, _explosiones) -> void:
	if nave is Player:
		print(player_objetivo)
		player_objetivo = null

func rotar_hacia_player() -> void:
	if player_objetivo:
		var dir_player:Vector2 = player_objetivo.global_position - global_position
		rotation = dir_player.angle()

## Señales internas
func _on_body_entered(body: Node) -> void:
	._on_body_entered(body)
	if body is Player:
		body.destruir()
		destruir()
