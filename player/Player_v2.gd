extends KinematicBody2D


var gravedad = 10
var direccion = Vector2.ZERO
var velocidad = 150

var point = preload("res://player/punto.tscn")
var puntos = []
var t = 0
var angulo_salto = deg2rad(-90)
var fuerza_salto = 200.0

var apuntando = false
var salto_a = true

export var salto_b_altura = 20
export var salto_a_distancia = 15

var dir_angulo = 0.1

export var apunte_automatico = true

var camara : Camera2D
var camara_zoom_normal = Vector2(0.5, 0.5)
var camara_zoom_out = Vector2(1,1)
var zoom = false

func _ready():
	$Flecha.rotation_degrees = -90
	
	for i in 20:
		puntos.append(point.instance())
		puntos[i].visible = false
		add_child(puntos[i])
	
	camara = get_parent().get_node("Camera2D")

func _physics_process(delta):
	
	if is_on_floor() and !apuntando:
		direccion.x = lerp(direccion.x, velocidad, 0.03)
	
	if apuntando:
		direccion.x = lerp(direccion.x, 0, 0.07)
	
	if !is_on_floor():
		direccion.y += gravedad
		if salto_a or (direccion.x > -1 and direccion.x < 1) : 
			direccion.x = lerp(direccion.x, velocidad, 0.05)
		
	direccion = move_and_slide_with_snap(direccion, Vector2.DOWN, Vector2.UP)


func _process(delta):
	
	zoom_out_camara(zoom)
	
	if Input.is_action_just_pressed("salto_a") and is_on_floor():
		direccion = Vector2(1,-1) * fuerza_salto 
		direccion.x -= (salto_a_distancia* 10)
		
		salto_a = true
	
	if Input.is_action_pressed("salto_b"):
		mostrar_puntos()
		apuntando = true
		$Flecha.visible = true
		zoom = true
		
	if Input.is_action_just_released("salto_b") and is_on_floor():
		$Flecha.rotation_degrees = -90
		ocultar_puntos()
		direccion = self.global_position.direction_to(puntos[9].global_position).normalized() * fuerza_salto * 2
		direccion += Vector2(0,-salto_b_altura)
		apuntando = false
		salto_a = false
		$Flecha.visible = false
		angulo_salto = deg2rad(-90)
		
		zoom = false
	
	camara.global_position.x = lerp(camara.global_position.x, self.global_position.x + 100, 0.08)
	camara.global_position.y = lerp(camara.global_position.y, self.global_position.y, 0.05)

	

func mostrar_puntos():
	
	if apunte_automatico:
		
		#APUNTAR AUTOMATICO
		for i in puntos:
			if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
				dir_angulo = -0.1
			if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
				dir_angulo = 0.1
			angulo_salto = lerp(angulo_salto, angulo_salto + dir_angulo, 0.007)
			
			i.position.x = (fuerza_salto * cos(angulo_salto) ) * t
			i.position.y = (fuerza_salto * sin(angulo_salto) * t) - (-gravedad/2) * t * t
			t = t + 0.5
			
			$Flecha.rotation = angulo_salto
		t = 0
	else:
		
	#APUNTAR MANUAL
		for i in puntos:
	#		i.visible = false
			if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
				angulo_salto = lerp_angle(angulo_salto, angulo_salto + 0.08, 0.01)
			if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
				angulo_salto = lerp_angle(angulo_salto, angulo_salto - 0.08, 0.01)

			i.position.x = (fuerza_salto * cos(angulo_salto) ) * t
			i.position.y = (fuerza_salto * sin(angulo_salto) * t) - (-gravedad/2) * t * t
			t = t + 0.5
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
			$Flecha.rotation = angulo_salto
		if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
			$Flecha.rotation = angulo_salto
		t = 0

func ocultar_puntos():
	for i in puntos:
		i.visible = false

func zoom_out_camara(switch : bool):
	if switch:
		camara.zoom.x = lerp(camara.zoom.x, camara_zoom_out.x, 0.05)
		camara.zoom.y = lerp(camara.zoom.y, camara_zoom_out.y, 0.05)
	else:
		camara.zoom.x = lerp(camara.zoom.x, camara_zoom_normal.x, 0.01)
		camara.zoom.y = lerp(camara.zoom.y, camara_zoom_normal.y, 0.01)

