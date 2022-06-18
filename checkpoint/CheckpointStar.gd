extends Area2D

func _ready():
	pass # Replace with function body.


func _on_CheckpointStar_body_entered(body):
	Checkpoints.last_position = global_position
