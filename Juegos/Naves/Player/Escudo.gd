class_name Escudo
extends Area2D

## Atributos
var esta_activado:bool = false setget, get_esta_activado

## Setters y Getters
func get_esta_activado() -> bool:
	return esta_activado

## Métodos
func _ready() -> void:
	controlar_colisionador(true)

## Métodos Custom
func controlar_colisionador(esta_activado: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", esta_activado)
	
func activar() -> void:	
	esta_activado = true
	controlar_colisionador(false)
	$AnimationPlayer.play("activando")

## Señales Internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "activando":
		$AnimationPlayer.play("activado")
