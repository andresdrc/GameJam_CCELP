extends Area2D

var enemigo

func _ready():
	enemigo = get_tree().get_nodes_in_group("body_enemigo")[0]

func _on_ZonaDeMuerte_body_entered(body):
		if body.name == "Player":
#			get_tree().reload_current_scene()
			body.global_position = Checkpoints.last_position
			enemigo.global_position.y = Checkpoints.last_position.y - 150
			enemigo.global_position.x = Checkpoints.last_position.x - 150

