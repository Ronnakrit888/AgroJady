extends Control

signal opened
signal closed

@onready var station_container = $NinePatchRect/MarginContainer/ScrollContainer/StationContainer
@onready var slots : Array = station_container.get_children()

var isOpen : bool = false

func open():
	Global.update_station.emit()
	update_plant_seed_amount()
	visible = true
	isOpen = true
	opened.emit()

func close():
	Global.update_station.emit()
	update_plant_seed_amount()
	visible = false
	isOpen = false
	closed.emit()

func update_plant_seed_amount() -> void :
	for child in slots :
		child.update_slots()
