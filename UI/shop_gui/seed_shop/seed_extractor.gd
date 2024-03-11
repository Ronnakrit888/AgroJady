extends HBoxContainer

@onready var seed = $Seed
@export var seedItem : PlantData

func _ready():
	_update_item_containers()

func _update_item_containers() -> void :
	update_ui(seed, seedItem.get_icon(), seedItem.get_amount())
	
func update_ui(node : Node, item_texture, item_amount) -> void :
	node.set_item_info(item_texture, item_amount)

func _on_texture_button_button_down():
	if (seedItem != null ) :
		if Global.coins >= seedItem.get_value() :
			seedItem.add_amount(1)
			Global.coins -= seedItem.get_value()
			_update_item_containers()
		else :
			return
			
func update_slots() -> void :
	seed.set_label(seedItem.get_amount())
	
