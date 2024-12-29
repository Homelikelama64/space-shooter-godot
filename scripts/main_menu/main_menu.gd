extends Node2D




func _on_button_button_down() -> void:
	Global.enemies = []
	Global.bullets = []
	Global.debug = false
	Global.paused = false
	Global.dead = false
	get_tree().paused = false
	Global.switch_scene("res://scenes/main/main.tscn")


func _on_exit_button_down() -> void:
	get_tree().quit(0)
