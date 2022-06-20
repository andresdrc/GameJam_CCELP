extends Area2D


func _on_ColisionDead_body_entered(body):
	if body.name == "Player":
		body.global_position = Checkpoints.last_position
