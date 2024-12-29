extends Node

var enemies:Array[Node2D] = []
var bullets:Array[Node2D] = []
var debug:bool = false
var paused:bool = false
var dead:bool = false

var player:Node2D
var explosion_resoure = preload("res://scenes/main/boom.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		var temp = debug
		if temp:
			debug = false
		if !temp:
			debug = true

func collisions(player:Node2D) -> void:
	for player_part in player.parts:
		for enemy in enemies:
				for enemy_part in enemy.parts:
					if check_part_collisions(player_part,enemy_part):
						player_part.health -= enemy_part.starting_health
						enemy_part.health -= player_part.starting_health
		for bullet in bullets:
			if !bullet.friendly:
				var reletive_pos = bullet.global_position - player_part.global_position
				if reletive_pos.length() < player_part.size + 10.0:
					player_part.health -= bullet.damage
					bullets.pop_at(get_index_of_object(bullets,bullet))
					bullet.queue_free()
					var explosion = explosion_resoure.instantiate()
					explosion.global_position = bullet.global_position
					explosion.emitting = true
					explosion.scale = Vector2(0.1,0.1)
					get_tree().root.add_child(explosion)
		if !(player_part.health >= 0):
			Global.dead = true
	
	for enemy_a in enemies:
		for ememy_a_part in enemy_a.parts:
			for enemy_b in enemies:
				for enemy_b_part in enemy_b.parts:
					if check_part_collisions(ememy_a_part,enemy_b_part):
						ememy_a_part.health -= enemy_b_part.starting_health
			for bullet in bullets:
				if bullet.friendly:
					var reletive_pos = bullet.global_position - ememy_a_part.global_position
					if reletive_pos.length() < ememy_a_part.size + 10.0:
						ememy_a_part.health -= bullet.damage
						bullets.pop_at(get_index_of_object(bullets,bullet))
						bullet.queue_free()
						var explosion = explosion_resoure.instantiate()
						explosion.global_position = bullet.global_position
						explosion.emitting = true
						explosion.scale = Vector2(0.1,0.1)
						get_tree().root.add_child(explosion)
	for enemy in enemies:
		for part in enemy.parts:
			if !(part.health > 0.0):
				enemies.pop_at(get_index_of_object(enemies,enemy))
				enemy.queue_free()
				var explosion = explosion_resoure.instantiate()
				explosion.global_position = enemy.global_position
				explosion.emitting = true
				get_tree().root.add_child(explosion)
	for bullet in bullets:
		if bullet.time > bullet.duration:
			bullets.pop_at(get_index_of_object(bullets,bullet))
			bullet.queue_free()

func get_index_of_object(array:Array[Node2D],object:Node2D) -> int:
	for i in range(0,array.size()):
		if array[i] == object:
			return i
	return -1

func check_part_collisions(a:Part,b:Part) -> bool:
	if a != b:
		var reletive_pos = b.global_position - a.global_position
		var dist = reletive_pos.length()
		if dist < a.size + b.size:
			return true
	return false


var current_scene = null
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	Global.enemies = []
	Global.bullets = []
	Global.debug = false
	Global.paused = false
	Global.dead = false
	get_tree().paused = false

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)
	
func _deferred_switch_scene(res_path):
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene


func _exit_tree() -> void:
	Global.debug = false
	Global.paused = false
	Global.dead = false
	get_tree().paused = false
