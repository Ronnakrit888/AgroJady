extends Control

class_name ShopGui

var isOpen : bool = false

func open():
	visible = true
	isOpen = true

func close():
	visible = false
	isOpen = false
