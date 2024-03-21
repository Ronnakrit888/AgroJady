extends StaticBody2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D
@onready var speech_sound = preload("res://SFX/punchy-taps-ui-5-183901.mp3")

const lines : Array[String] = [
	"Hey!" ,
	"How your feeling?"
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogManager.start_dialog(global_position, lines, speech_sound)
	sprite.flip_h = true if interaction_area.get_overlapping_bodies()[0].global_position.x < global_position.x else false
	await DialogManager.dialog_finished
