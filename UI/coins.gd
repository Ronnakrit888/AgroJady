extends Control

@onready var icon = $TextureRect
@onready var text = $Label

func _physics_process(delta):
	text.text = str(Global.coins)
