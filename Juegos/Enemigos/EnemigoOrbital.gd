class_name EnemigoOrbital
extends EnemigoBase

## Atributos export
export var rango_max_ataque: float = 1400.0

## Atributos
var estacion_duenia:Node2D

## Constructor
func crear(pos:Vector2, duenia:Node2D) -> void:
	global_position = pos
	estacion_duenia = duenia

## Métodos
func _ready() -> void:
	canion.set_esta_disparando(true)
	
## Métodos Custom
func rotar_hacia_player() -> void:
	.rotar_hacia_player()
	if dir_player.length() > rango_max_ataque:
		canion.set_esta_disparando(false)
	else:
		canion.set_esta_disparando(true)
	



