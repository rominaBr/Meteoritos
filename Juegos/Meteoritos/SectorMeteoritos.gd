class_name SectorMeteoritos
extends Node2D

## Atributos export
export var cantidad_meteoritos:int = 10
export var intervalo_spawn:float = 1.2

## Atributos
var spawners:Array

## Constructor
func crear(pos:Vector2, meteoritos:int) -> void:
	global_position = pos
	cantidad_meteoritos = meteoritos	

## Métodos
func _ready() -> void:
	$AnimationPlayer.play("default")
	almacenar_spawners()
	conectar_seniales_detectores()
	$SpawnTimer.wait_time = intervalo_spawn

## Métodos Custom	
func almacenar_spawners() -> void:
	$AnimationPlayer.play("advertencia")	
	for spawner in $Spawners.get_children():			
		spawners.append(spawner)
		
func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()

func conectar_seniales_detectores() -> void:
	for detector in $DetectorFueraZona.get_children():
		detector.connect("body_entered", self, "_on_detector_body_entered")	

## Señales internas
func _on_SpawnTimer_timeout() -> void:	
	if cantidad_meteoritos <= 0:		
		$SpawnTimer.stop()
		$AnimationPlayer.play("default")
		return		
	spawners[spawner_aleatorio()].spawnear_meteorito()	
	cantidad_meteoritos -= 1

## Señales externas
func _on_detector_body_entered(body: Node) -> void:		
	body.set_esta_en_sector(false)
