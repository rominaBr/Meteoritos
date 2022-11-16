class_name ContenedorInformacion
extends NinePatchRect

## Atributos onready
onready var texto_contenedor:Label = $Label
onready var auto_ocultar_timer:Timer = $AutoOcultarTimer
onready var animaciones:AnimationPlayer = $AnimationPlayer

## Atributos
var auto_ocultar:bool = true setget set_auto_ocultar

## Setters y getters
func set_auto_ocultar(ocultar:bool) -> void:
	if ocultar:
		ocultar()
	else:
		mostrar_suavizado()

## Métodos Custom
func mostrar() -> void:
	$AnimationPlayer.play("mostrar")
	
func ocultar() -> void:
	$AnimationPlayer.play("ocultar")
	
func mostrar_suavizado() -> void:
	$AnimationPlayer.play("mostrar_suavizado")
	
func ocultar_suavizado() -> void:
	$AnimationPlayer.play("ocultar_suavizado")
	
func modificar_texto(text:String) -> void:
	texto_contenedor.text = text

## Señales internas
func _on_AutoOcultarTimer_timeout() -> void:
	ocultar_suavizado()
