extends Control

func _ready():
	Checkpoints.last_position = null

func _on_Button_pressed():
	get_tree().change_scene("res://mundo/Mundo_1.tscn")
	pass # Replace with function body.
