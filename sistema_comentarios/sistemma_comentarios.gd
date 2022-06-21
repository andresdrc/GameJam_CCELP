extends CanvasLayer

var comentarios = {
"inicio" : "Hola soy Rainy, una aventurera de otro mundo. Andaba en medio de una exploración y de pronto una luz apareció frente a mi. Era un portal. Una energía extraña me rodeo y cuando me di cuenta estaba cayendo. Ahora estoy aquí. Me pregunto a dónde me llevará esta nueva aventura.",
"sale_portal" : "Me siento diferente… ¿me veo diferente? No importa. Este lugar se ve interesante.",
"salto_alto" : "Esto se está complicando, en hora de saltar seriamente.",
"enemigo_comentario" : "¿Amigo o enemigo?",
"enemigo_2" : "Enemigo… \n Okay, ya debo irme. No eres tú, soy yo. \n ¡Hora de correr!",
"victoria_1" : "Eso fur tan fácil como mi paseo por el Éverest.",
"victoria_2" : "Hora de una nueva aventura.",
"victoria_3" : "Libertad !!!",
"victoria_4" : "No olvides ser asombroso.",
"pierde_1" : "Caida libre.",
"pierde_2" : "Mas suerte para la proxima",
"pierde_3" : "¿Otra vez?.",
"fin" : "¡Hasta las estrellas!",
"mensaje_final" : "Hola, aquí Rainy actualizando su bitácora. Mi nueva aventura me ha llevado a cruzar el universo y en el camino he conocido a las estrellas. Son seres increíbles. Espero contarles sus historias algún día. Hasta pronto. ¡No olviden ser asombrosos!",
"tutorial_1" : "Haces un   SALTO SIMPLE   con el boton   Z  , usalo para saltar   MUROS PEQUENIOS   o   DISTANCIAS CORTAS",
"tutorial_2" : "Para hacer  SALTO LARGO   MANTEN PRESIONADO   el boton   X  y   APUNTA   con las   FLECHAS  , usalo para saltar muros   MUY ALTOS   o   DISTANCIAS LARGAS  , Las   ESTRELLAS   te avisaran cando usar   SALTO LARGO",
}

onready var rich_text = $Control/MarginContainer/MarginContainer/RichTextLabel
onready var tween = $Control/MarginContainer/Tween
var duracion_tween
export var letra_x_seg = 15

var mostrando_comentarios = false

var contador_boton = 0

func mostrar_comentario(comentario : String):
	$Control.visible = true
	dialogo(comentario)


func _process(delta):
	if Input.is_action_just_pressed("salto_a") and mostrando_comentarios and get_tree().paused:
		contador_boton += 1
		if contador_boton >= 2 :
			get_tree().paused = false
			$Control.visible = false
			contador_boton = 0


func dialogo(comentario : String):
	rich_text.bbcode_text = comentarios[comentario]
#	duracion_tween =  comentarios[comentario].length() / letra_x_seg
	duracion_tween =  2
	
	tween.interpolate_property(
		rich_text, "percent_visible", 0, 1 , duracion_tween,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	print(rich_text.percent_visible)
	tween.start()
	
