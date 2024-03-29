extends HBoxContainer

@export var seedItem : PlantData

@onready var seed = $Seed
@onready var flash = $flash

func _ready():
	_update_item_containers()

func _update_item_containers() -> void :
	update_ui(seed, seedItem.get_icon(), seedItem.get_amount())
	
func update_ui(node : Node, item_texture, item_amount) -> void :
	node.set_item_info(item_texture, item_amount)

func _on_texture_button_button_down():
	if (seedItem != null ) :
		print(Global.coins)
		if Global.coins >= seedItem.get_value() :
			seedItem.add_amount(1)
			Global.remove_coin(seedItem.get_value())
			_update_item_containers()
		else :
			flash.play("flash_animation")
			
func update_slots() -> void :
	seed.set_label(seedItem.get_amount())
	
