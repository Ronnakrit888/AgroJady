extends CanvasLayer

@onready var inventory = $InventoryGUI
@onready var hotbar_seed = $HotbarSeed
@onready var sellZone = $SellZoneGUI
@onready var seed_shop_gui = $SeedShopGUI

var can_open_inv : bool = true

func _ready():
	inventory.close()

func _input(event):
	if event.is_action_pressed("Inventory") && can_open_inv :
		if inventory.isOpen:
			inventory.close()
			
		else:
			inventory.open()

func setup_hotbar_seed() -> void :
	hotbar_seed.initialize()
	
func hotbar_slot_empty(seed) -> void :
	hotbar_seed.is_slot_empty(seed)

func _on_sell_zone_gui_closed():
	can_open_inv = true

func _on_sell_zone_gui_opened():
	can_open_inv = false
	
func _on_seed_shop_gui_closed():
	can_open_inv = true

func _on_seed_shop_gui_opened():
	can_open_inv = false
