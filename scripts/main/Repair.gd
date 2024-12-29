extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var ran_before = false
var damaged_last_tick = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(dt: float) -> void:
	if !ran_before:
		ran_before = true
		randomise_pos()
	var damaged = false
	for part in Global.player.parts:
		var reletive_pos:Vector2 = part.global_position - global_position
		if reletive_pos.length() < part.size + 16.0:
			for repaired_part in Global.player.parts:
				repaired_part.health = repaired_part.starting_health
			randomise_pos()
	for part in Global.player.parts:
		if part.health != part.starting_health:
			damaged = true
	if damaged != damaged_last_tick && damaged:
		randomise_pos()
	damaged_last_tick = damaged
	var display:Sprite2D = get_node("Display")
	var reletive_pos = global_position - Global.player.global_position
	display.global_position = Global.player.global_position + reletive_pos.normalized() * 150.0
	if reletive_pos.length() > 150.0 && damaged:
		display.visible = true
	else:
		display.visible = false

func angle_to_vector(angle: float) -> Vector2:
	return Vector2(cos(angle - PI / 2.0),sin(angle - PI / 2.0))
	

func rotate_vector(vector:Vector2,angle:float) -> Vector2:
	return Vector2(vector.x * cos(angle) - vector.y * sin(angle),vector.x * sin(angle) + vector.y * cos(angle))

func randomise_pos():
	global_position = Global.player.global_position + angle_to_vector(randf() * TAU) * (randf() + 1) * 2000.0
