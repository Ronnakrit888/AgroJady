extends Node

@onready var text_box_scene = preload("res://UI/text_box.tscn")

var dialog_lines : Array[String] = []
var current_line_index = 0

var text_box
var text_box_positon : Vector2
var tail_pos : float

var sfx : AudioStream

var is_dialog_active : bool = false
var can_advance_line : bool = false

signal dialog_finished()

func start_dialog(pos : Vector2, lines : Array[String], speech_sfx : AudioStream, tail_position = 0.5) :
	if is_dialog_active :
		return
		
	dialog_lines = lines
	text_box_positon = pos
	sfx = speech_sfx
	tail_pos = tail_position
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box() :
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_positon
	text_box.display_text(dialog_lines[current_line_index], sfx)
	can_advance_line = false
	
func _on_text_box_finished_displaying() :
	can_advance_line = true
	

func _unhandled_input(event):
	if (
		event.is_action_pressed("left click") && is_dialog_active && can_advance_line
	):
		text_box.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			dialog_finished.emit()
			return
		
		_show_text_box()
	
	
