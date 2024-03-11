extends StaticBody2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var screenSize = get_viewport().get_visible_rect().size
@onready var shop_ui = $"../GUI/SeedShopGUI"
@onready var hotbar_seed = $"../GUI/HotbarSeed"

var original_pos_hot 

func _ready():
	interaction_area.interact = Callable(self, "_open_ui")
	shop_ui.close()
	
func _open_ui():
	if shop_ui.isOpen :
		shop_ui.close()
		hotbar_seed.update_inventory()
		create_tween().set_ease(Tween.EASE_IN).tween_property(
			hotbar_seed, "position:y", original_pos_hot, 0.8)
	else:
		shop_ui.open()
		hotbar_seed.update_inventory()
		original_pos_hot = hotbar_seed.position.y
		create_tween().set_ease(Tween.EASE_OUT).tween_property(
			hotbar_seed, "position:y", screenSize.y + hotbar_seed.size.y, 0.8)

func _on_interaction_area_leave_area():
	shop_ui.close()
