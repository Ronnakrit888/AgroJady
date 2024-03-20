extends StaticBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var interaction_area : InteractionArea = $InteractionArea

func _ready():
	animated_sprite.frame = 0
	interaction_area.interact =Callable(self, "_open_ui")

func _open_ui():
	print("Chestttt")
	
func _on_interaction_area_leave_area():
	pass
