extends Node2D

@onready var tree = $Summer/Tree
@onready var tree_cold = preload("res://scenes/resourec_node/resource_node_tree_cold.tscn")
@onready var tree_orange = preload("res://scenes/resourec_node/resource_node_tree_orange.tscn")
@onready var tree_pink = preload("res://scenes/resourec_node/resource_node_tree_pink.tscn")
@onready var tree_pink2 = preload("res://scenes/resourec_node/resource_node_tree_pink_2.tscn")
@onready var tree_summer = preload("res://scenes/resourec_node/resource_node_tree_summer.tscn")

var markers_list : Array = []

func _ready():
	spawn_resource(tree_cold)
	
func spawn_resource(scene : PackedScene):
	for mark in tree.get_children() :
		if mark not in markers_list :
			var tree = scene.instantiate()
			get_parent().call_deferred("add_child", tree)
			tree.global_position = mark.global_position
			markers_list.append(mark)
	
		
		
