extends ItemList

var player:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().root.get_node("/root/Main/player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clear()
	for part in player.parts:
		if Global.display_percentage:
			add_item(part.Name + ":" + str(part.health / part.starting_health * 100.0).pad_decimals(0) + "%",null,false)
		else:
			add_item(part.Name + ":" + str(part.health).pad_decimals(1) + "/" + str(part.starting_health).pad_decimals(1),null,false)
