extends Node2D

var rect:ColorRect
var time = 0.0
@export var speed = 32
@export var damage = 1
@export var duration = 1
@export var friendly = true


func _ready() -> void:
	Global.bullets.push_back(self)
	rect = get_node("Rect")
	if friendly:
		rect.color.r = 0
		rect.color.g = 1
		rect.color.b = 0
	else:
		rect.color.r = 1
		rect.color.g = 0
		rect.color.b = 0

func _process(dt: float) -> void:
	time += dt

func _physics_process(dt: float) -> void:
	global_position += angle_to_vector(global_rotation) * speed * dt

func angle_to_vector(angle: float) -> Vector2:
	return Vector2(cos(angle - PI / 2.0),sin(angle - PI / 2.0))
