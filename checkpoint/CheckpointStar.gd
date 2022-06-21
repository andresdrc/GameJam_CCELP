extends Area2D


func _ready():
	pass # Replace with function body.


func _on_CheckpointStar_body_entered(body):
	Checkpoints.last_position = global_position
	get_parent().get_node("Camera2D").global_position = Checkpoints.last_position
