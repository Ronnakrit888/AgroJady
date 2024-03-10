extends Button

@onready var backgroundSprite : Sprite2D  = $Background
@onready var container : CenterContainer = $CenterContainer

@onready var inventoryRecipe = preload("res://UI/crafting_gui/SlotShowItem.tres")

var itemStackGui : ItemStackGUI
var currentItemShow : ItemStackGUI = null
var index : int

func insert(isg : ItemStackGUI):
	itemStackGui = isg
	
	var newitemStackGui = isg.duplicate()
	
	if currentItemShow :
		container.remove_child(currentItemShow)	
		
	container.add_child(newitemStackGui)
	currentItemShow = newitemStackGui
	
	if !newitemStackGui.inventorySlot || inventoryRecipe.slots[index] == itemStackGui.inventorySlot:
		return
	
	inventoryRecipe.insertSlot(index, newitemStackGui.inventorySlot)

func isEmpty():
	return !itemStackGui
