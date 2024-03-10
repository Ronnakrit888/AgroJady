extends Control

@onready var icon = $TextureRect
@onready var text = $Label

func _ready():
	text.text = str(Global.coins)
