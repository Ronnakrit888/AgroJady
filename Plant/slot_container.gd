extends PanelContainer

signal slot_selected(slot_pos)

@onready var itemInfo = $ItemInfo

var seedDataResource : PlantData

func setup(value) :
	seedDataResource = value
	seedDataResource.amount_changed.connect(_on_amount_changed)
	itemInfo.set_item_info(seedDataResource.get_icon(), seedDataResource.get_amount())

func _on_texture_button_button_down():
	if seedDataResource != null and seedDataResource.seed_left() : Global.emit_signal("seed_changed", seedDataResource)
	emit_signal("slot_selected", position)

func update_amount() -> void :
	itemInfo.set_label(seedDataResource.get_amount())
	
func _on_amount_changed(new_amount) -> void :
	itemInfo.set_label(new_amount)
	
func play_slot_item_empty() -> void :
	itemInfo.play_flash_animation()
