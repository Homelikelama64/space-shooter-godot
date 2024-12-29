extends Node2D
class_name Gun

@export var time = 0.0
@export var interval = 1.0
@export var angle = 0.0
@export var friendly = true
@export var speed = 32.0
@export var damage = 1.0
@export var duration = 1.0
@export var ticking = false

var bullet_resource = preload("res://scenes/main/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt: float) -> void:
	if ticking:
		time += dt
	while time > interval:
		time -= interval
		var bullet:Node2D = bullet_resource.instantiate()
		bullet.global_position = global_position
		bullet.rotation = angle
		bullet.friendly = friendly
		bullet.speed = speed
		bullet.damage = damage
		bullet.duration = duration
		get_node("/root/Main").add_child(bullet)
