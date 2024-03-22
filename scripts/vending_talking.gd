extends StaticBody2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var speech_sound = preload("res://SFX/DialogSound.mp3")

const lines : Array[String] = [
	"Hello," ,
	"I am Vendy.",
	"The Magic Living ",
	"HA HA HA HA "
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogManager.start_dialog(global_position, lines, speech_sound)	
	await DialogManager.dialog_finished
