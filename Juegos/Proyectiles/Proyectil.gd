class_name Proyectil
extends Area2D

## Atributos Export
export var danio:float = 2.0

## Atributos
var velocidad:Vector2 = Vector2.ZERO


## Métodos
func crear(pos: Vector2, dir: float, vel: float, danio_p: int) -> void:
	position = pos
	rotation = dir
	velocidad = Vector2(vel, 0).rotated(dir)
	
func _physics_process(delta: float) -> void:
	position += velocidad * delta

## Métodos custom
func daniar(otro_cuerpo: CollisionObject2D) -> void:	
	if otro_cuerpo.has_method("recibir_danio"):				
		otro_cuerpo.recibir_danio(danio)		
	queue_free()	

## Señales internas
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	daniar(body)

func _on_area_entered(area: Area2D) -> void:	
	daniar(area)
