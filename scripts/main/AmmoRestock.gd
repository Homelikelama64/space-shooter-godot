extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var ran_before = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(dt: float) -> void:
	if !ran_before:
		ran_before = true
		randomise_pos()
	for part in Global.player.parts:
		var reletive_pos:Vector2 = part.global_position - global_position
		if reletive_pos.length() < part.size + 16.0:
			for gun in Global.player.guns:
				gun.ammo = gun.total_ammo
			randomise_pos()
	var display:Sprite2D = get_node("Display")
	var reletive_pos = global_position - Global.player.global_position
	display.global_position = Global.player.global_position + reletive_pos.normalized() * 150.0
	if reletive_pos.length() > 150.0:
		display.visible = true
	else:
		display.visible = false
	if (Global.player.global_position - global_position).length() > 2500:
		randomise_pos()

func angle_to_vector(angle: float) -> Vector2:
	return Vector2(cos(angle - PI / 2.0),sin(angle - PI / 2.0))
	

func rotate_vector(vector:Vector2,angle:float) -> Vector2:
	return Vector2(vector.x * cos(angle) - vector.y * sin(angle),vector.x * sin(angle) + vector.y * cos(angle))

func randomise_pos():
	global_position = Global.player.global_position + angle_to_vector(randf() * TAU) * (randf() + 1) * 1000.0
