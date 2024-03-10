extends Button

@onready var backgroundSprite : AnimatedSprite2D = $background
@onready var container : CenterContainer = $CenterContainer

@onready var inventory = preload("res://UI/Inv.tres")

var itemStackGui : ItemStackGUI
var index : int

func insert(isg : ItemStackGUI):
	itemStackGui = isg
	backgroundSprite.play("filled")
	container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot:
		return
	
	inventory.insertSlot(index, itemStackGui.inventorySlot)

func takeItem():
	var item = itemStackGui
	
	inventory.removeSlot(itemStackGui.inventorySlot)
	
	container.remove_child(itemStackGui)
	itemStackGui = null
	backgroundSprite.play("empty")
	
	return item

func isEmpty():
	return !itemStackGui
