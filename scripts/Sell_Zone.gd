extends StaticBody2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sell_ui = $"../GUI/SellZoneGUI"

func _ready():
	interaction_area.interact = Callable(self, "_open_ui")
	sell_ui.close()
	
func _open_ui():
	if sell_ui.isOpen :
		sell_ui.close()
	else:
		sell_ui.open()


func _on_interaction_area_leave_area():
	sell_ui.close()
