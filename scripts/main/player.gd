extends Node2D

var velocity = Vector2.ZERO

var ship_speed_original = 250.0
var turn_speed_left_original = 100.0
var turn_speed_right_original = 100.0
var ship_speed = ship_speed_original
var turn_speed_left = turn_speed_left_original
var turn_speed_right = turn_speed_right_original

@export var parts:Array[Part] = []
@export var damage_source:Array[String] = []
@export var damage_target:Array[String] = []
@export var damage_scale:Array[float] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = randf() * TAU


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt: float) -> void:
	ship_speed = ship_speed_original
	turn_speed_left = turn_speed_left_original
	turn_speed_right = turn_speed_right_original
	for i in range(0,damage_source.size()):
		var part:Part
		for a_part in parts:
			if a_part.Name == damage_source[i]:
				part = a_part
				break
		var health = 1.0 - (1.0 - part.health / part.starting_health) * damage_scale[i]
		if damage_target[i] == "Turn Left":
			turn_speed_left *= health
		if damage_target[i] == "Turn Right":
			turn_speed_right *= health
		if damage_target[i] == "Speed":
			ship_speed *= health
		if has_node(damage_target[i]):
			var node:CPUParticles2D = get_node(damage_target[i])
			node.spread = lerp(node.get_meta("spread_max"),node.get_meta("spread_min"),health)
	if Input.is_action_pressed("turn_left"):
		rotation_degrees -= turn_speed_left * dt
	if Input.is_action_pressed("turn_right"):
		rotation_degrees += turn_speed_right * dt
			
	if Input.is_action_pressed("shoot"):
		get_node("Gun").ticking = true
		get_node("Gun2").ticking = true
	else:
		get_node("Gun").ticking = false
		get_node("Gun2").ticking = false
	get_node("Gun").angle = global_rotation
	get_node("Gun2").angle = global_rotation

func _physics_process(dt: float) -> void:
	velocity += angle_to_vector(rotation) * (ship_speed - (velocity.length() * (2.0 + (velocity.normalized().dot(angle_to_vector(rotation)))) / 2.0)) * dt
	var right = angle_to_vector(rotation - PI / 2.0)
	velocity -= right * right.dot(velocity) * dt
	position += velocity * dt
	Global.collisions(self)

func angle_to_vector(angle: float) -> Vector2:
	return Vector2(cos(angle - PI / 2.0),sin(angle - PI / 2.0))
	

func rotate_vector(vector:Vector2,angle:float) -> Vector2:
	return Vector2(vector.x * cos(angle) - vector.y * sin(angle),vector.x * sin(angle) + vector.y * cos(angle))

