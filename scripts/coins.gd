extends Control

@onready var label = $NinePatchRect/Label

func _process(delta):
	label.text = str(Global.coins)
