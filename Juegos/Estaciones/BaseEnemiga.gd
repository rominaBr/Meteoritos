class_name BaseEnemiga
extends Node2D

## Atributos export
export var hitpoints:float = 30.0

## Atributos onready
onready var impacto_sfx:AudioStreamPlayer2D = $ImpactoSFX

## Atributos
var esta_destruida:bool = false

## Métodos
func _ready() -> void:
	$AnimationPlayer.play(elegir_animacion_aleatoria())

## Métodos custom
func elegir_animacion_aleatoria() -> String:
	randomize()
	var num_anim:int = $AnimationPlayer.get_animation_list().size() - 1
	var indice_anim_aleatoria:int = randi() % num_anim + 1
	var lista_animacion:Array = $AnimationPlayer.get_animation_list()
	
	return lista_animacion[indice_anim_aleatoria]

func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	print("hitpoints base enemiga",hitpoints)
	if hitpoints <= 0 and not esta_destruida:
		esta_destruida = true
		queue_free()
		
	impacto_sfx.play()	


func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()
