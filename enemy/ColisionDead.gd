extends Area2D

var pos_ini

func _ready():
	pos_ini = self.global_position
	print(pos_ini)


func _on_ColisionDead_body_entered(body):
	if body.name == "Player":
		body.global_position = Checkpoints.last_position
		get_parent().global_position = pos_ini
		print(self.global_position)

