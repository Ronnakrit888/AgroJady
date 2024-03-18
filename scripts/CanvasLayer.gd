extends CanvasLayer

@onready var inventory = $InventoryGUI
@onready var hotbar_seed = $HotbarSeed
@onready var sellZone = $SellZoneGUI

func _ready():
	inventory.close()

func _input(event):
	if event.is_action_pressed("Inventory") && !sellZone.isOpen :
		if inventory.isOpen:
			inventory.close()
			
		else:
			inventory.open()

func setup_hotbar_seed() -> void :
	hotbar_seed.initialize()
	
func hotbar_slot_empty(seed) -> void :
	hotbar_seed.is_slot_empty(seed)
