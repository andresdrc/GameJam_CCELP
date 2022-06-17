extends KinematicBody2D


var gravedad = 10
var direccion = Vector2.ZERO
var velocidad

var point = preload("res://player/punto.tscn")
var puntos = []
var t = 0
var angulo_salto = deg2rad(-90)
var fuerza_salto = 300.0


func _ready():
	
	for i in 20:
		puntos.append(point.instance())
		puntos[i].visible = false
		add_child(puntos[i])


func _physics_process(delta):
	
	if !is_on_floor():
		direccion.y += gravedad
		
	direccion = move_and_slide_with_snap(direccion, Vector2.DOWN, Vector2.UP)


func _process(delta):
	
	if Input.is_action_pressed("salto_b"):
		direccion = Vector2.ZERO
		mostrar_puntos()
	if Input.is_action_just_released("salto_b"):
		ocultar_puntos()
		direccion += self.global_position.direction_to(puntos[9].global_position) * fuerza_salto * 3
		print(direccion)


func mostrar_puntos():
	for i in puntos:
		i.visible = true
		
		#APUNTAR MANUAL
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
			angulo_salto = lerp_angle(angulo_salto, angulo_salto + 0.08, 0.01)
		if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
			angulo_salto = lerp_angle(angulo_salto, angulo_salto - 0.08, 0.01)
		
		i.position.x = (fuerza_salto * cos(angulo_salto) ) * t
		i.position.y = (fuerza_salto * sin(angulo_salto) * t) - (-gravedad/2) * t * t
#		i.position.y = ((fuerza_salto * sin(angulo_salto) - gravedad * t) * sin(angulo_salto) * t) - (-gravedad/2) * t * t
		t = t + 0.5
		
	t = 0

func ocultar_puntos():
	for i in puntos:
		i.visible = false












#
#var direccion = Vector2.ZERO
#var mov_direcion = Vector2.ZERO
#var gravedad = Vector2(0,9)
#var velocidad = 100
#
#
#var point = preload("res://player/punto.tscn")
#var puntos = []
#var t = 0
#var angulo_salto
#var dir_angulo
#var fuerza_salto = 100
#var stop = false
#
#
#func _ready():
#
#	for i in 20:
#		puntos.append(point.instance())
#		puntos[i].visible = false
#		add_child(puntos[i])
#
#
#func mostrar_puntos():
#	for i in puntos:
#		i.visible = true
#
#		#APUNTAR AUTOMATICO
#		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
#			dir_angulo = -0.1
#		if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
#			dir_angulo = 0.1
#		angulo_salto = lerp(angulo_salto, angulo_salto + dir_angulo, 0.007)
#
#		#APUNTAR MANUAL
##		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
##			angulo_salto = lerp_angle(angulo_salto, angulo_salto + 0.08, 0.01)
##		if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
##			angulo_salto = lerp_angle(angulo_salto, angulo_salto - 0.08, 0.01)
#
#		i.position.x = fuerza_salto/3.2 * cos(angulo_salto) * t
#		i.position.y = fuerza_salto/3.2 * sin(angulo_salto) * t - (-gravedad/2) * t * t
#		t = t + 0.5
#
#	t = 0
#
#
#func _physics_process(delta):
#
#	direccion.normalized()
#
#	direccion.x = 1
#	direccion.y += 0.1
#
##	direccion = move_and_slide_with_snap(direccion.normalized() * velocidad, Vector2.DOWN, Vector2.UP)
#
#	direccion = move_and_slide(direccion * velocidad, Vector2.UP)
#	print(direccion.abs())
#
#
#func _process(delta):
#
#	if Input.is_action_pressed("salto_b") and is_on_floor():
#		direccion.x = lerp(direccion.x, 0, 0.06)
#		stop = true
#		mostrar_puntos()
#
#	if Input.is_action_just_released("salto_b") and is_on_floor():
#		direccion.x = 0
#		t = 0
#		ocultar_puntos()
#
#		direccion = self.global_position.direction_to(puntos[9].global_position) * fuerza_salto * 3
#		print(direccion)
#
#		stop = false
#
#		angulo_salto = deg2rad(-90)
#		dir_angulo = 0.1
#
#
#func ocultar_puntos():
#	for i in puntos:
#		i.visible = false
#
#
#
#func _input(event):
#
#	if Input.is_action_pressed("ui_right"):
#		direccion.x = 1
#	if Input.is_action_just_released("ui_right"):
#		direccion.x = 0
#
#	if Input.is_action_pressed("ui_left"):
#		direccion.x = -1
#	if Input.is_action_just_released("ui_left"):
#		direccion.x = 0
#
#	if Input.is_action_pressed("ui_down"):
#		direccion.y = 1
#	if Input.is_action_just_released("ui_down"):
#		direccion.y = 0
#
#	if Input.is_action_pressed("ui_up"):
#		direccion.y = -1
#	if Input.is_action_just_released("ui_up"):
#		direccion.y = 0
#
#

