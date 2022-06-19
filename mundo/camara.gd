extends Camera2D

var player 
var pos_ini = Vector2.ZERO

func _ready():
	
	pos_ini = get_parent().get_node("Player").global_position
	
	self.global_position = get_parent().get_node("Player").global_position
	player = get_parent().get_node("Player")
	
	
func _process(delta):
	
	self.global_position = lerp(self.global_position, player.global_position, 0.03)
	
	self.global_position.y = clamp(pos_ini.y, pos_ini.y - 5000,  pos_ini.y + 5000)

#	self.global_position = player.global_position
	
