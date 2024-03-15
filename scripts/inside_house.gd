extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var farm_map = preload("res://scenes/game_leveltscn.tscn")

var change_scene : bool = false

func _on_area_2d_body_entered(body):
	change_scene = true
	#get_tree().change_scene_to_packed(farm_map)
	change_scene = false
	
