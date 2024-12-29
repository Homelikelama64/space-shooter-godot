@tool
extends Node2D
class_name Part


@export var health:float
@export var starting_health:float
@export var size:float
@export var Name:String

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if Engine.is_editor_hint() || Global.debug:
		draw_circle(Vector2.ZERO,size,Color.GREEN)
	pass
