extends Control

@onready var money_label = $HBoxContainer/Label

func _ready():
	money_label = str(Global.money)
