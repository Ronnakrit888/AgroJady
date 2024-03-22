extends Control

class_name Mainmenu

@onready var start_button = $VBoxContainer/HBoxContainer/StartButton
@onready var setting_button = $VBoxContainer/HBoxContainer/SettingButton
@onready var exit_button = $VBoxContainer/HBoxContainer/ExitButton

@export var start_level = preload("res://scenes/world.tscn") as PackedScene
@export var settings_scene = preload("res://UI/Main menu/main menu/setting_menu.tscn") as PackedScene


func _ready():
	start_button.button_down.connect(on_start_pressed)
	setting_button.button_down.connect(on_setting_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	

func on_start_pressed() -> void :
	#click_sound.play()
	
	get_tree().change_scene_to_packed(start_level)
	
func on_setting_pressed() -> void :
	#click_sound.play()
	#await.
	
	get_tree().change_scene_to_packed(settings_scene)

func on_exit_pressed() -> void:
	#click_sound.play()
	get_tree().quit()
	
