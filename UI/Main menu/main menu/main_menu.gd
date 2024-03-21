extends Control

class_name Mainmenu

@onready var start_button = $VBoxContainer/HBoxContainer/StartButton
@onready var setting_button = $VBoxContainer/HBoxContainer/SettingButton

@export var start_level = preload("res://scenes/world.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_start_pressed)
	setting_button.button_down.connect(on_setting_pressed)
	

func on_start_pressed() -> void :
	get_tree().change_scene_to_packed(start_level)
	
func on_setting_pressed() -> void :
	pass
