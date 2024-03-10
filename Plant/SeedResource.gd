extends Resource

class_name SeedResource

@export var seedList : Array[PlantData]

func get_seed_data(value) -> PlantData :
	for child in seedList :
		if child.get_seed_name() == value :
			return child
	return null
	
func get_size() -> int :
	return seedList.size()
	
func get_seed_list() -> Array[PlantData] :
	return seedList
