extends StaticBody2D

@onready var door_anim = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea

@export var connected_scene : String 
var scene_folder = "res://scenes/"

func _ready():
	interaction_area.interact = Callable(self, "_change_scene")
	door_anim.play("close")

func _change_scene() :
	door_anim.play("open")
	await door_anim.animation_finished
	var full_path = scene_folder + connected_scene + ".tscn"
	var scene_tree = get_tree()
	scene_tree.call_deferred("change_scene_to_file", full_path)
	door_anim.play("close")	

func _on_interaction_area_leave_area():
	door_anim.play("close")
