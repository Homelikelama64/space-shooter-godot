extends Node2D

var player:Node2D

var velocity = Vector2.ZERO

var speed = 600.0

@export var parts:Array[Part] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/Main/player")
	Global.enemies.push_back(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(dt: float) -> void:
	var right = angle_to_vector(rotation - PI / 2.0)
	var reletive_pos = player.position - position
	if right.dot(player.position - position) < 0.0:
		rotation_degrees += 80.0 * dt
	else:
		rotation_degrees -= 80.0 * dt
	
	velocity += angle_to_vector(rotation) * (speed - (velocity.length() * (2.0 + (velocity.normalized().dot(angle_to_vector(rotation)))) / 2.0)) * dt
	velocity -= right * right.dot(velocity) * dt
	position += velocity * dt
	

func angle_to_vector(angle: float) -> Vector2:
	return Vector2(cos(angle - PI / 2.0),sin(angle - PI / 2.0))
	

func rotate_vector(vector:Vector2,angle:float) -> Vector2:
	return Vector2(vector.x * cos(angle) - vector.y * sin(angle),vector.x * sin(angle) + vector.y * cos(angle))

func _exit_tree() -> void:
	var partical_emmiter = get_node("CPUParticles2D")
	partical_emmiter.reparent(get_tree().root)
	partical_emmiter.emitting = false
