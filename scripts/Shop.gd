extends StaticBody2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var shop_ui = $"../GUI/ShopGUI"

func _ready():
	interaction_area.interact = Callable(self, "_open_ui")
	shop_ui.close()
	
func _open_ui():
	if shop_ui.isOpen :
		shop_ui.close()
	else:
		shop_ui.open()

func _on_interaction_area_leave_area():
	shop_ui.close()
