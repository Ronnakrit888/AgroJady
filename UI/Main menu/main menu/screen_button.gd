extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var button = $Button

func set_text(text : String):
	label.text = text

func get_text() -> String :
	return label.text
