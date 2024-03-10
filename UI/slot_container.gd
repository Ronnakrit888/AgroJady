extends PanelContainer

signal slot_selected(slot_pos)

@onready var itemInfo = $ItemInfo

var itemDataResource : EquippableItemData

func setup(value) :
	itemDataResource = value
	itemInfo.set_item_info(itemDataResource.get_item_icon(), itemDataResource.get_item_name())

func _on_texture_button_button_down():
	if itemDataResource.get_item_texture() != null : Global.emit_signal("item_equip_changed", itemDataResource)
	emit_signal("slot_selected", position)

func update_item_name() -> void :
	itemInfo.set_label(itemDataResource.get_item_name())
