extends Control


onready var v1 = $MarginContainer/HBoxContainer/TextureRect
onready var v2 = $MarginContainer/HBoxContainer/TextureRect2
onready var v3 = $MarginContainer/HBoxContainer/TextureRect3
onready var v4 = $MarginContainer/HBoxContainer/TextureRect4
onready var v5 = $MarginContainer/HBoxContainer/TextureRect5


var vect_vidas = []
var cant_vidas_iniciales

func _ready():
	vect_vidas.append(v1)
	vect_vidas.append(v2)
	vect_vidas.append(v3)
	vect_vidas.append(v4)
	vect_vidas.append(v5)
	
	cant_vidas_iniciales = get_parent().get_parent().get_node("Player").cant_vidas
	
	for i in vect_vidas:
		i.visible = false
	
	for i in cant_vidas_iniciales:
		vect_vidas[i].visible = true


func actualizar_cant_vidas(cant : int):
	
	if cant <= 5:
#		print("llego: ", cant)
		if cant <= 0:
			print("REINICIAR JUEGO")
			get_tree().change_scene("res://menu_inicio/Menu_inicio.tscn")
		
		for i in vect_vidas:
			i.visible = false
#			print(i)
		
		for i in cant:
			vect_vidas[i].visible = true
	
	
