class_name Escudo
extends Area2D

## Atributos Export
export var energia: float = 8.0
export var radio_desgaste: float = -1.6

## Atributos
var esta_activado:bool = false setget, get_esta_activado
var energia_origina:float

## Setters y Getters
func get_esta_activado() -> bool:
	return esta_activado

## Métodos
func _ready() -> void:
	energia_origina = energia
	set_process(false)
	controlar_colisionador(true)
	
func _process(delta: float) -> void:
	controlar_energia(radio_desgaste * delta)

## Métodos Custom
func controlar_colisionador(esta_activado: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", esta_activado)

func controlar_energia(consumo:float) -> void:
	energia += consumo
	if energia > energia_origina:
		energia = energia_origina
	elif energia <= 0.0:
		Eventos.emit_signal("ocultar_energia_escudo")
		desactivar()
		return
		
	Eventos.emit_signal("cambio_energia_escudo", energia_origina, energia)
	
func activar() -> void:	
	if energia <= 0.0:
		return
		
	esta_activado = true
	controlar_colisionador(false)
	$AnimationPlayer.play("activando")

func desactivar() -> void:
	set_process(false)
	esta_activado = false
	controlar_colisionador(true)
	$AnimationPlayer.play_backwards("activando")
	$AudioStreamPlayer.stop()

## Señales Internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "activando" and esta_activado:
		$AnimationPlayer.play("activado")
		set_process(true)

func _on_body_entered(body: Node) -> void:
	body.queue_free()
