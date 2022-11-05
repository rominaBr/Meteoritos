class_name SectorMeteoritos
extends Node2D

## Atributos export
export var cantidad_meteoritos:int = 10

## Atributos
var spawners:Array

## Métodos
func _ready() -> void:
	$AnimationPlayer.play("advertencia")	
	almacenar_spawners()

## Métodos Custom	
func almacenar_spawners() -> void:	
	for spawner in $Spawners.get_children():		
		spawners.append(spawner)
		
func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()
	

## Señales internas
func _on_SpawnTimer_timeout() -> void:	
	if cantidad_meteoritos == 0:
		$SpawnTimer.stop()
		$AnimationPlayer.play("default")
		return		
	spawners[spawner_aleatorio()].spawnear_meteorito()
	cantidad_meteoritos -= 1
