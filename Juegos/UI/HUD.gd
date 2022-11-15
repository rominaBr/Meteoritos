extends CanvasLayer

## Métodos
func _ready() -> void:
	Eventos.connect("nivel_iniciado", self, "fade_out")
	Eventos.connect("nivel_terminado", self, "fade_in")
	
	
## Métodos custom
func fade_in() -> void:
	$FadeCanvas/AnimationPlayer.play("fade_in")
	
func fade_out() -> void:
	$FadeCanvas/AnimationPlayer.play_backwards("fade_in")
