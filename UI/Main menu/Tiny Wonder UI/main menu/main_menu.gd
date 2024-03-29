class_name Mainmenu
extends Control

@onready var settings_button = $MarginContainer/HBoxContainer/VBoxContainer/Settings_Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var settings_menu = $Settings_Menu as SettingsMenu
@onready var margin_container = $MarginContainer as MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connecting_signals()
	
func on_settings_pressed() -> void:
	margin_container.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true
	
func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_exit_settings_menu() -> void:
	margin_container.visible = true
	settings_menu.visible = false

func handle_connecting_signals() -> void:
	settings_button.button_down.connect(on_settings_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	settings_menu.exit_settings_menu.connect(on_exit_settings_menu)
