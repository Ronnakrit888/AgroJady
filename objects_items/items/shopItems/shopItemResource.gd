extends Resource

class_name ShopItemResource

@export var shop_item_list : Array[ShopItemData]

func get_item_data(value) -> ShopItemData :
	for child in shop_item_list :
		if child.get_seed_name() == value :
			return child
	return null
	
func get_size() -> int :
	return shop_item_list.size()
	
func get_seed_list() -> Array[ShopItemData] :
	return shop_item_list

func get_item_value(value) :
	for child in shop_item_list :
		return child.get_value()
