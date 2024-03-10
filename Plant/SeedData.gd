extends Resource

class_name PlantData

signal amount_changed(new_amount)

@export var plantItem : ItemPlant
@export var plantScene : PackedScene

func seed_left() -> bool :
	return plantItem.amount > 0
	
func add_amount(value : int) -> void :
	if value > 0 : plantItem.amount += value
	
func substract_amount() -> void :
	if seed_left() : plantItem.amount -= 1
	amount_changed.emit(plantItem.amount)

func get_icon() -> Texture2D :
	return plantItem.icon
	
func get_amount() -> int :
	return plantItem.amount
	
func get_seed_name() -> String :
	return plantItem.display_name
	
func get_type() -> String :
	return plantItem.type
