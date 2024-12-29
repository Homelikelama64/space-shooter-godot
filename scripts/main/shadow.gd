@tool
extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var light_dir = Vector2(1.0,1.0).normalized()
	material.set_shader_parameter("dir",rotate_vector(light_dir,-global_rotation))

func angle_to_vector(angle: float) -> Vector2:
	return Vector2(cos(angle - PI / 2.0),sin(angle - PI / 2.0))
	

func rotate_vector(vector:Vector2,angle:float) -> Vector2:
	return Vector2(vector.x * cos(angle) - vector.y * sin(angle),vector.x * sin(angle) + vector.y * cos(angle))
