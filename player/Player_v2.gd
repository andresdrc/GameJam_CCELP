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

var cant_vidas = 3
var ui_juego
var cant_vida_max = 5
var caida_salto = false

var salto_largo = false

var sistema_comentarios

var vel_apuntar = 0.05


func _ready():
	$Flecha.rotation_degrees = -90
	
	for i in 20:
		puntos.append(point.instance())
		puntos[i].visible = false
		add_child(puntos[i])
	
	camara = get_parent().get_node("Camera2D")	
	ui_juego = get_parent().get_node("UI_videojuego/Control")
	
	sistema_comentarios = get_parent().get_node("Sistema_comentarios")


func _physics_process(delta):
	
	direccion = move_and_slide_with_snap(direccion, Vector2.DOWN, Vector2.UP)
	
	if is_on_floor() and !apuntando:
		direccion.x = lerp(direccion.x, velocidad, 0.03)
	
	if apuntando:
		direccion.x = lerp(direccion.x, 0, 0.09)
	
	if !is_on_floor():
		direccion.y += gravedad
		if salto_a or (direccion.x > -1 and direccion.x < 1) : 
			direccion.x = lerp(direccion.x, velocidad, 0.005 * (velocidad/7))
	
	if !is_on_floor() and direccion.x < (velocidad * 0.02) and direccion.x > -(velocidad * 0.02):
		direccion.x = lerp(direccion.x, velocidad, 0.1)


func _process(delta):
	
	zoom_out_camara(zoom)
	
	if Input.is_action_just_pressed("salto_a") and is_on_floor():
		direccion = Vector2(1,-1) * fuerza_salto 
		direccion.x -= (salto_a_distancia* 10)
		
		salto_a = true
	
	if Input.is_action_pressed("salto_b") and is_on_floor() and !caida_salto:
		mostrar_puntos()
		apuntando = true
		$Flecha.visible = true
		zoom = true
		
		caida_salto = false
	
	if Input.is_action_just_released("salto_b") and is_on_floor():
		if !caida_salto:
		
			$Flecha.rotation_degrees = -90
			ocultar_puntos()
			direccion = self.global_position.direction_to(puntos[9].global_position).normalized() * fuerza_salto * 2
			direccion += Vector2(0,-salto_b_altura)
			apuntando = false
			salto_a = false
			$Flecha.visible = false
			angulo_salto = deg2rad(-90)
			
			zoom = false
			
			salto_largo = true
		else:
			caida_salto = false
			
	if Input.is_action_just_released("salto_b") and !is_on_floor() and caida_salto:
		caida_salto = false
	
	if apuntando and !is_on_floor():
		$Flecha.rotation_degrees = -90
		ocultar_puntos()
		apuntando = false
		salto_a = false
		$Flecha.visible = false
		angulo_salto = deg2rad(-90)
		
		zoom = false
		
		caida_salto = true
	
	
	
	if direccion.x == 0 and !apuntando:
#		print("PUSH")
		$AnimatedSprite.play("push")
		$AnimatedSprite.flip_h = false
#	if direccion.x > 10 and direccion.x < 290 and is_on_floor():
	if direccion.x > (velocidad * 0.03) and direccion.x < (velocidad * 0.96) and is_on_floor():
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
#	if direccion.x > 290 and is_on_floor():
	if direccion.x > (velocidad * 0.96) and is_on_floor():
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
#	if direccion.x < 60 and direccion.x > -60 and apuntando and is_on_floor() and apuntando:
	if direccion.x < (velocidad * 0.20) and direccion.x > -(velocidad * 0.20) and apuntando and is_on_floor() and apuntando:
		$AnimatedSprite.play("idle")
		$AnimatedSprite.flip_h = false
	if !is_on_floor() and direccion.x > 0:
		$AnimatedSprite.play("jump")
	if !is_on_floor() and direccion.x < 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("jump")
#	print($AnimatedSprite.animation)

	
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
#			if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right"):
			if Input.is_action_pressed("ui_right"):
				angulo_salto = lerp_angle(angulo_salto, angulo_salto + 0.08, vel_apuntar)
#			if  Input.is_action_pressed("ui_left")or Input.is_action_pressed("ui_down"):
			if  Input.is_action_pressed("ui_left"):
				angulo_salto = lerp_angle(angulo_salto, angulo_salto - 0.08, vel_apuntar)
				
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


func actualizar_vida(cant : int):
	cant_vidas = cant


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemigo"):
		actualizar_vida( cant_vidas -1)
#		print(cant_vidas)
		ui_juego.actualizar_cant_vidas(cant_vidas)
		
	if area.is_in_group("vida"):
		if cant_vidas < cant_vida_max:
			actualizar_vida( cant_vidas + 1)
#			print("cant v: ", cant_vidas)
			ui_juego.actualizar_cant_vidas(cant_vidas)
	
	if area.is_in_group("comentario_1"):
		sistema_comentarios.mostrando_comentarios = true
		sistema_comentarios.mostrar_comentario("inicio")
		get_tree().paused = true
