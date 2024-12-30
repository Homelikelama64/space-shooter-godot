extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var was_visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if was_visible != visible:
	get_node("VBoxContainer/display_percentage").button_pressed = Global.display_percentage
	get_node("VBoxContainer/debug").button_pressed = Global.debug
	was_visible = visible


func _on_check_button_toggled(toggled_on: bool) -> void:
	Global.display_percentage = toggled_on


func _on_settings_toggled(toggled_on: bool) -> void:
	if toggled_on:
		visible = true
	else:
		visible = false


func _on_debug_toggled(toggled_on: bool) -> void:
	Global.debug = toggled_on
