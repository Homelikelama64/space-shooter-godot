extends Camera2D

var tracked_object:Node2D

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tracked_object = get_node("/root/Main/player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(dt: float) -> void:
	#var reletive_pos = tracked_object.position - position
	#velocity += reletive_pos * dt * 10.0
	#velocity += (velocity * 0.1 - velocity) * dt
	#position += velocity * dt
	if !(Global.paused || Global.dead):
		position = vector_lerp(position,tracked_object.position,0.1) 

func vector_lerp(a:Vector2,b:Vector2,t:float) -> Vector2:
	return Vector2(lerp(a.x,b.x,t),lerp(a.y,b.y,t))


func lerp(a:float,b:float,t:float) -> float:
	return a + (b - a) * t
