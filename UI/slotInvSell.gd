extends Button

@onready var background_sprite : AnimatedSprite2D = $background
@onready var item_stack_gui : ItemStackGUI = $CenterContainer/Panel

var index : int 

func update_to_slot(slot : InventorySlot) -> void :
	if !slot.item :
		item_stack_gui.visible = false
		background_sprite.play("empty")
		return
	
	item_stack_gui.inventorySlot = slot
	item_stack_gui.update()
	item_stack_gui.visible = true
	
	background_sprite.play("filled")

