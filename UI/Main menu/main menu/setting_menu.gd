extends Control

@onready var h_box_container = $VBoxContainer/HBoxContainer
#@export var menu_scene = preload("res://UI/Main menu/main menu/main_menu.gd") as PackedScene
var screen_mode : String

const WINDOW_MODE_ARRAY : Array[String] = [
	"Full-Screen",
	"Window Mode",
	"Borderless Window",
	"Sounds"
	
]



func _ready():
	var button_index = 0
	for window_mode in WINDOW_MODE_ARRAY :
		if button_index < h_box_container.get_child_count():
			var button = h_box_container.get_child(button_index)
			button.set_text(window_mode)
			button_index += 1
		else:
			break
		
	for screen_button in h_box_container.get_children():
		var callable = Callable(_on_button_down)
		callable = callable.bind(screen_button)
		screen_button.button.button_down.connect(callable)
		#get_window().mode = Window.MODE_MAXIMIZED
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN

func _on_button_down(button):
	match button.get_text() :
		"Full-Screen":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		"Borderless Window":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		"Window Mode":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		"Sounds":
			pass
		#"Back":
			#get_tree().change_scene_to_packed(menu_scene)
			
			
