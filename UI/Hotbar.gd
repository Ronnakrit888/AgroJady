extends HBoxContainer

@onready var inventory : Inventory = preload("res://UI/Inv.tres")
@onready var slots : Array = get_children()

var hand_equip : HandEquip

func _ready():
	update()
	connectSlots()
	inventory.updated.connect(update)

func update() -> void :
	for i in range(slots.size()) :
		var inventory_slot : InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
		slots[i].index = i
		
func connectSlots():
	for slot in slots :
		var callable = Callable(onSlotSelected)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func onSlotSelected(slot) :
	var item = inventory.slots[slot.get_index()].item
	if (item is HarvestingTool) :
		setEquipItem(item)
	else :
		return
	
func setEquipItem(item) :
	if scene_manager.player :
		hand_equip = scene_manager.player.find_child("HandEquip")
		if hand_equip :
			hand_equip.equipped_item = item
			return
	
