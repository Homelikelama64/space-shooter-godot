extends Node2D

var blur_material_resource = preload("res://materials/blur.tres")

func _ready() -> void:
	Global.enemies = []
	Global.bullets = []
	Global.debug = false
	Global.paused = false
	Global.dead = false
	Global.player = %player
	get_tree().paused = false

var time = 0.0;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt: float) -> void:
	if Input.is_action_just_pressed("pause"):
		var temp = Global.paused
		if temp:
			Global.paused = false
		if !temp:
			Global.paused = true
	if !(Global.paused || Global.dead):
		time += dt
	get_tree().paused = Global.paused || Global.dead
	var blur:ColorRect = get_node("Camera2D/ColorRect")
	var health_display:ItemList = get_node("Camera2D/ItemList")
	if Global.paused || Global.dead:
		blur.visible = true
		pass
	else:
		blur.visible = false
	if Global.dead:
		blur.material.set("shader_parameter/tint",Vector4(1.0,0.5,0.5,1))
	else:
		blur.material.set("shader_parameter/tint",Vector4(1.0,1.0,1.0,1))
	var pause_menu = get_node("Camera2D/Pause Menu")
	if Global.paused && !Global.dead:
		pause_menu.visible = true
		health_display.visible = false
	else:
		pause_menu.visible = false
		health_display.visible = true
	var death_screen = get_node("Camera2D/Death Screen")
	if Global.dead:
		death_screen.visible = true
	else:
		death_screen.visible = false
	var timer = get_node("Camera2D/timer")
	timer.text = str(time).pad_decimals(1) + "s"


func _on_resume_button_down() -> void:
	Global.paused = false


func _on_exit_button_down() -> void:
	get_tree().quit(0)


func _on_restart() -> void:
	Global.switch_scene("res://scenes/main/main.tscn")


func _on_main_menu_button_down() -> void:
	#Global.debug = false
	#Global.paused = false
	#Global.dead = false
	Global.switch_scene("res://scenes/main_menu.tscn")
