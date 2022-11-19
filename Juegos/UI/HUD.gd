extends CanvasLayer

## Atributos export
export var icono_vidas:PackedScene = null

## Atributos onready
onready var info_zona_recarga:ContenedorInformacion = $InfoZonaRecarga
onready var info_meteoritos:ContenedorInformacion = $InfoMeteoritos
onready var info_tiempo_restante:ContenedorInformacion = $InfoTiempoRestante
onready var info_laser:ContenedorInformacionEnergia = $InfoLaser
onready var info_escudo:ContenedorInformacionEnergia = $InfoEscudo

## Atributos
var offset_vidas:float  = 60.0

## Métodos
func _ready() -> void:
	conectar_seniales()
	info_tiempo_restante.set_esta_activo(true)
	Eventos.emit_signal("actualizar_vidas")
	
## Métodos custom
func conectar_seniales() -> void:
	Eventos.connect("nivel_iniciado", self, "fade_out")
	Eventos.connect("nivel_terminado", self, "fade_in")
	Eventos.connect("detecto_zona_recarga", self, "_on_detecto_zona_recarga")
	Eventos.connect("cambio_numero_meteoritos", self, "_on_actualizar_info_meteoritos")
	Eventos.connect("actualizar_tiempo", self, "_on_actualizar_info_tiempo")
	Eventos.connect("cambio_energia_laser", self, "_on_actualizar_energia_laser")
	Eventos.connect("ocultar_energia_laser", info_laser, "ocultar")
	Eventos.connect("cambio_energia_escudo", self, "_on_actualizar_energia_escudo")
	Eventos.connect("ocultar_energia_escudo", info_escudo, "ocultar")
	Eventos.connect("actualizar_vidas", self, "_on_actualizar_vidas")
	
func fade_in() -> void:
	$FadeCanvas/AnimationPlayer.play("fade_in")
	
func fade_out() -> void:
	$FadeCanvas/AnimationPlayer.play_backwards("fade_in")		
	
func _on_actualizar_vidas() -> void:
	for i in DatosJuego.vidas:
		var nueva_vida:Sprite= icono_vidas.instance()
		self.add_child(nueva_vida)
		nueva_vida.global_position.x -= offset_vidas * i
		
func _on_detecto_zona_recarga(en_zona: bool) -> void:
	if en_zona:
		info_zona_recarga.set_esta_activo(true)
		info_zona_recarga.mostrar_suavizado()
	else:
		info_zona_recarga.ocultar_suavizado()

func _on_actualizar_info_meteoritos(numero:int) -> void:
	info_meteoritos.set_esta_activo(true)
	info_meteoritos.mostrar_suavizado()
	info_meteoritos.modificar_texto(
		"Meteoritos restantes\n {cantidad}".format({"cantidad":numero})
	)

func _on_actualizar_info_tiempo(tiempo_restante:int) -> void:
	#warning-ignore:narrowing_conversion
	var minutos:int = floor(tiempo_restante * 0.016666666666667)
	var segundos:int = tiempo_restante % 60
	info_tiempo_restante.modificar_texto(
		"Tiempo restante\n%02d:%02d" % [minutos, segundos]
	)
	if tiempo_restante % 10 == 0:		
		info_tiempo_restante.mostrar_suavizado()
	if tiempo_restante == 11:		
		info_tiempo_restante.set_auto_ocultar(false)
	if tiempo_restante < 11 and tiempo_restante >= 0:
		info_tiempo_restante.animaciones.play("tiempo_limite")
	elif tiempo_restante == 0:
		info_tiempo_restante.animaciones.stop()
		info_tiempo_restante.ocultar()
		

func _on_actualizar_energia_laser(energia_max:float, energia_actual:float) -> void:
	info_laser.set_esta_activo(true)
	info_laser.mostrar()
	info_laser.actualizar_energia(energia_max, energia_actual)

func _on_actualizar_energia_escudo(energia_max:float, energia_actual:float) -> void:
	info_escudo.set_esta_activo(true)
	info_escudo.mostrar()
	info_escudo.actualizar_energia(energia_max, energia_actual)
