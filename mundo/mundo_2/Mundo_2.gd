extends Node2D

var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	player.salto_corto_activado = true
	player.salto_largo_activado = true
	
	Checkpoints.nivel = 2

func _enter_tree():
	if Checkpoints.last_position:
		$Player.global_position = Checkpoints.last_position

