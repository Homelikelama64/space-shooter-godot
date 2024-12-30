extends Node2D
class_name Wave

@export var time = 0.0
@export var interval = 6.0
@export var path = "scenes/main/V1Enemy.tscn"
@export var min_interval = 1.0
@export var interval_delta = 0.1
@export_range(0.0,1.0) var extra_spawn_chance = 0.1
@export var ticking = true

var enemy_resource = load("res://" + path)


var player:Node2D

func _ready() -> void:
	player = get_node("/root/Main/player")
	enemy_resource = load("res://" + path)

func _process(dt: float) -> void:
	time += dt
	while time > interval:
		var spawn_count = 1
		while spawn_count > 0:
			time -= interval
			interval = max(min_interval,interval - interval_delta)
			var object:Node2D = enemy_resource.instantiate()
			object.position = player.position + angle_to_vector(randf() * PI * 2) * 1000.0
			add_sibling(object)
			spawn_count -= 1
			if randf() < extra_spawn_chance:
				spawn_count += 1

func angle_to_vector(angle: float) -> Vector2:
	return Vector2(cos(angle - PI / 2.0),sin(angle - PI / 2.0))
