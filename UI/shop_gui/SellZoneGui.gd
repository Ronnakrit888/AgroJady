extends Control

class_name SellZoneGui

signal opened
signal closed

@onready var inventory : Inventory = preload("res://UI/Inv.tres")
@onready var slotsInventory : Array = $NinePatchRect/InventoryContainer.get_children()

var isOpen : bool = false
var itemInHand : ItemStackGUI

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	
func update() -> void :
	for i in range(slotsInventory.size()) :
		var inventory_slot : InventorySlot = inventory.slots[i]
		slotsInventory[i].update_to_slot(inventory_slot)
		slotsInventory[i].index = i
	
func connectSlots():
	for slot in slotsInventory :
		var callable = Callable(onSlotSelected)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func onSlotSelected(slot) :
	slot.takeItem()
	
func open():
	visible = true
	isOpen = true
	opened.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()
