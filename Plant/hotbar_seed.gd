extends PanelContainer

@export var slotScene : PackedScene
@export var seedResource : SeedResource

@onready var selector_texture = $MarginContainer/SelectorTexture
@onready var grid_container = $MarginContainer/GridContainer

func initialize() :
	grid_container.columns = seedResource.get_size()
	add_new_slot(seedResource.get_seed_list())
	
func add_new_slot(seedArray : Array[PlantData]) -> void :
	for child in seedArray :
		instance_slot(child)
		
	var firstSlot = grid_container.get_child(0)
	Global.emit_signal("seed_changed", firstSlot.seedDataResource)
	change_selected_slot(firstSlot.position)

func instance_slot(seedData : PlantData) -> void :
	var slot = slotScene.instantiate()
	grid_container.add_child(slot)
	slot.connect("slot_selected", _on_slot_selected)
	slot.setup(seedData)
	
func _on_slot_selected(value) -> void :
	change_selected_slot(value)
	
func change_selected_slot(slot_pos) -> void :
	selector_texture.position.x = slot_pos.x + $MarginContainer.get_theme_constant("margin_left")

func is_slot_empty(seedData : PlantData) -> void :
	for child in grid_container.get_children() :
		if child.seedDataResource == seedData :
			child.play_slot_item_empty()

func update_inventory() -> void :
	for child in grid_container.get_children() :
		child.update_amount()
