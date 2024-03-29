extends KinematicBody2D


export var vel = 200
export var fuerza_salto = 70
export var gravedad = 7
var direccion = Vector2.ZERO

var direccion_salto = Vector2.ZERO
var angulo_salto = deg2rad(-90)
var puntos = []
var t = 0.2
var stop = false
var dir_angulo = 0.1
var cant_suelo = 0
var salto_largo = false

var camara_pos_ini = Vector2.ZERO

var point = preload("res://player/punto.tscn")

func _ready():
	
	for i in 20:
		puntos.append(point.instance())
		puntos[i].visible = false
		add_child(puntos[i])
	
	camara_pos_ini = $Camera2D.global_position
	$Flecha.rotation_degrees = -90


func _process(delta):
	
#	if !stop:
#		direccion.x = lerp(direccion.x, vel, 0.005)
	if is_on_floor() and !stop:
#		direccion.x = lerp(direccion.x, vel, 0.005)
		direccion.x = vel
		
	if !is_on_floor():
		direccion.y += gravedad
		direccion.x += 1
	else:
		direccion.y = 0

	if Input.is_action_just_pressed("salto_a") and is_on_floor():
#		direccion.y = -fuerza_salto
		
		direccion += Vector2(0.001,-2.5) * fuerza_salto
		print(direccion)
		
	if Input.is_action_pressed("salto_b") and is_on_floor():
		direccion.x = lerp(direccion.x, 0, 0.1)
		stop = true
		mostrar_puntos()

		$Flecha.visible = true
	
	if Input.is_action_just_released("salto_b") and is_on_floor():
		direccion.x = 0
		t = 0
		$Flecha.rotation_degrees = -90
		ocultar_puntos()
		direccion += self.global_position.direction_to(puntos[9].global_position) * fuerza_salto * 6
		print(direccion)
		
		stop = false
		salto_largo = true
		
		angulo_salto = deg2rad(-90)
		dir_angulo = 0.1
		
		$Flecha.visible = false
		


	direccion = move_and_slide_with_snap(direccion ,Vector2.DOWN,Vector2.UP)

func _physics_process(delta):
	
	
	pass

func mostrar_puntos():
	for i in puntos:
#		i.visible = true
		
		#APUNTAR AUTOMATICO
#		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
#			dir_angulo = -0.1
#		if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
#			dir_angulo = 0.1
#		angulo_salto = lerp(angulo_salto, angulo_salto + dir_angulo, 0.007)
		
		#APUNTAR MANUAL
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
			angulo_salto = lerp_angle(angulo_salto, angulo_salto + 0.1, 0.05)
		if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
			angulo_salto = lerp_angle(angulo_salto, angulo_salto - 0.1, 0.05)
			
		i.position.x = (fuerza_salto/4.7 * cos(angulo_salto) ) * t
		i.position.y = (fuerza_salto/4.7 * sin(angulo_salto) * t) - (-gravedad/2) * t * t
#		i.position.y = ((fuerza_salto * sin(angulo_salto) - gravedad * t) * sin(angulo_salto) * t) - (-gravedad/2) * t * t
		t = t + 0.5
		
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
		$Flecha.rotation = angulo_salto
	if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
		$Flecha.rotation = angulo_salto
	t = 0


func ocultar_puntos():
	for i in puntos:
		i.visible = false

