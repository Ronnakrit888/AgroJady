extends Area2D

class_name SceneTrigger

@export var connected_scene : String 

func _on_body_entered(body):
	if body is Player :
		scene_manager.change_scene(get_owner(), connected_scene)
