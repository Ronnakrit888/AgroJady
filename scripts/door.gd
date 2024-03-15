extends StaticBody2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var inside_house = preload("res://scenes/inside_house.tscn")
@onready var door_anim = $AnimationPlayer

func _ready():
	interaction_area.interact = Callable(self, "_change_scene")
	door_anim.play("close")
	
func _change_scene() :
	door_anim.play("open")
	await door_anim.animation_finished
	get_tree().change_scene_to_packed(inside_house)
	door_anim.play("close")

func _on_interaction_area_leave_area():
	door_anim.play("close")
