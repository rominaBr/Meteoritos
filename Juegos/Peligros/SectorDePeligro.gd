extends Area2D

## Atributos export
export(String, "vacio", "Meteorito", "Enemigo") var tipo_peligro
export var numero_peligros:int = 10

##Señales
func _on_body_entered(_body: Node) -> void:
	pass # Replace with function body.
	
func enviar_senial() -> void:
	Eventos.emit_signal(
		"nave_en_sector_peligroso",
		$PositionCentroSector.global_position,
		tipo_peligro,
		numero_peligros
	)
	queue_free()
