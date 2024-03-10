extends Button

class_name slotCrafting

@onready var backgroundSprite : Sprite2D = $Background
@onready var container : CenterContainer = $CenterContainer

@onready var inventoryShop : Inventory = preload("res://objects_items/items/ItemsCrafting/Inventory_shop.tres")

var itemStackGui : ItemStackGUI
var index : int

func insert(isg : ItemStackGUI):
	itemStackGui = isg
	container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot || inventoryShop.slots[index] == itemStackGui.inventorySlot:
		return
	
	inventoryShop.insertSlot(index, itemStackGui.inventorySlot)

func isEmpty():
	return !itemStackGui

