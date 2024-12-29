@tool
extends Sprite2D

var pos = Vector2(0.0,0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt: float) -> void:
	pos += Vector2(0.0,1.0) * dt * 10.0
	material.set("shader_parameter/position",pos)
