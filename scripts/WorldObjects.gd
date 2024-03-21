extends Node2D

@onready var marker_summer = $Summer
@onready var tree_cold = preload("res://scenes/resourec_node/resource_node_tree_cold.tscn") 
@onready var tree_orange = preload("res://scenes/resourec_node/resource_node_tree_orange.tscn")
@onready var tree_pink = preload("res://scenes/resourec_node/resource_node_tree_pink.tscn")
@onready var tree_pink2 = preload("res://scenes/resourec_node/resource_node_tree_pink_2.tscn")
@onready var tree_summer = preload("res://scenes/resourec_node/resource_node_tree_summer.tscn")

var spawned_count : int = 0

func _ready():
	spawn_resource(marker_summer ,tree_cold)
	
func spawn_resource(node_marker : Node2D, scene : PackedScene):
	for mark in node_marker.get_children() :
		if (spawned_count <= node_marker.get_child_count()) :
			var tree_scene = scene.instantiate()
			get_parent().call_deferred("add_child", tree_scene)
			tree_scene.resource_node_queue_free.connect(_on_resource_queue_free)
			tree_scene.global_position = mark.global_position
			spawned_count += 1
		
func _on_resource_queue_free():
	pass
