extends Area2D

func _on_ZonaDeMuerte_body_entered(body):
		if body.name == "Player":
			body.global_position = Checkpoints.last_position
			#get_tree().reload_current_scene()

