extends Resource

class_name ShopItemData

@export var item : Item
@export var value : int

func get_icon() -> Texture :
	return item.icon
	
func get_seed_name() -> String :
	return item.display_name
	
func get_value() -> int :
	return value
	
