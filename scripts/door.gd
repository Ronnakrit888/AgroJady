extends StaticBody2D

@onready var door_anim = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea


func _ready():
	interaction_area.interact = Callable(self, "_change_scene")
	door_anim.play("close")

func _change_scene() :
	door_anim.play("open")
	await door_anim.animation_finished
	print("Changed")
	door_anim.play("close")	

func _on_interaction_area_leave_area():
	door_anim.play("close")
