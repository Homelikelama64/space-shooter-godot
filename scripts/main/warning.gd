
extends Sprite2D

var player:Node2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player = get_node("/root/Main/player")
	var reletive_pos = player.position - get_parent().position
	global_position = player.position - reletive_pos.normalized() * 75
	global_rotation = 0.0
	if reletive_pos.length() < 75:
		visible = false
	else:
		visible = true
