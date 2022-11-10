class_name CamaraPlayer
extends Camera2D

## Variables export
export var variacion_zoom:float = 0.1

## Métodos
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_acercar"):
		controlar_zoom(-variacion_zoom)
	elif event.is_action_pressed("zoom_alejar"):
		controlar_zoom(variacion_zoom)

## Métodos custom
func controlar_zoom(mod_zoom: float) -> void:
	zoom.x += mod_zoom
	zoom.y += mod_zoom
