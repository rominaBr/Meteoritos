class_name NaveBase
extends RigidBody2D

## Enums
enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}

## Atributos Export
export var hitpoints:float = 20.0

## Atributos
var estado_actual:int = ESTADO.SPAWN

## Atributos onready
onready var colisionador:CollisionShape2D = $CollisionShape2D
onready var sonido_danio:AudioStreamPlayer = $ImpactoSFX
onready var canion:Canion = $Canion


## Metodos
func _ready() -> void:
	controlador_estados(estado_actual)
	controlador_estados(ESTADO.VIVO)

	
## Metodos Custom
func controlador_estados(nuevo_estado:int) -> void:
	match nuevo_estado:
		ESTADO.SPAWN:
			colisionador.set_deferred("disabled", true)
			canion.set_puede_disparar(false)
		ESTADO.VIVO:
			colisionador.set_deferred("disabled", false)
			canion.set_puede_disparar(true)
		ESTADO.INVENCIBLE:
			colisionador.set_deferred("disabled", true)
			
		ESTADO.MUERTO:
			colisionador.set_deferred("disabled", true)
			canion.set_puede_disparar(false)
			Eventos.emit_signal("nave_destruida", self, global_position, 3)
			queue_free()
		_:
			print("Error de estado")
	
	estado_actual = nuevo_estado

func esta_input_activo() -> bool:
	if estado_actual in [ESTADO.MUERTO, ESTADO.SPAWN]:
		return false
	return true


func recibir_danio(danio: float) -> void:	
	hitpoints -= danio	
	if hitpoints <= 0.0:		
		destruir()
	sonido_danio.play()		

func destruir() -> void:
	controlador_estados(ESTADO.MUERTO)

## Señales internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "spawn":
		controlador_estados(ESTADO.VIVO)

func _on_body_entered(body: Node) -> void:
	if body is Meteorito:
		body.destruir()
		destruir()
