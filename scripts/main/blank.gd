extends Node2D


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	Global.enemies = []
	Global.bullets = []
	Global.debug = false
	Global.paused = false
	Global.dead = false
	Global.switch_scene("res://scenes/main.tscn")

