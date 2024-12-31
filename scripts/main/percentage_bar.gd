@tool
extends Sprite2D

@export var health = 0.5
@export_color_no_alpha var on_color:Color
@export_color_no_alpha var off_color:Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	material.set("shader_parameter/health",health)
	material.set("shader_parameter/health_color",Vector4(on_color.r,on_color.g,on_color.b,on_color.a))
	material.set("shader_parameter/dead_color",Vector4(off_color.r,off_color.g,off_color.b,off_color.a))
