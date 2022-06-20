extends KinematicBody2D

var Speed = 75
var velocity = Vector2()

func _physics_process(delta: float) -> void:
	var to_player = ($"../Player".position-position).normalized()
	velocity = to_player*Speed
	move_and_collide(velocity*delta)


