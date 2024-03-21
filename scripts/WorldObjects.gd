extends Node2D

@onready var marker_summer = $Summer
@onready var marker_spring = $Spring
@onready var marker_winter = $Winter
@onready var marker_autumn = $Autumn
@onready var tree_cold = preload("res://scenes/resourec_node/resource_node_tree_cold.tscn") 
@onready var tree_orange = preload("res://scenes/resourec_node/resource_node_tree_orange.tscn")
@onready var tree_pink = preload("res://scenes/resourec_node/resource_node_tree_pink.tscn")
@onready var tree_pink2 = preload("res://scenes/resourec_node/resource_node_tree_pink_2.tscn")
@onready var tree_summer = preload("res://scenes/resourec_node/resource_node_tree_summer.tscn")

var spawned_count_summer : int = 0
var spawned_count_spring : int = 0
var spawned_count_winter : int = 0
var spawned_count_autumn : int = 0

func _ready():
	spawn_resource(marker_summer ,tree_summer)
	spawn_resource(marker_spring, tree_orange)
	spawn_resource(marker_winter, tree_pink)
	spawn_resource(marker_autumn, tree_cold)
	
func spawn_resource(node_marker : Node2D, scene : PackedScene):
	var spawned_count_var : int
	
	# Summer
	if node_marker == marker_summer:
		spawned_count_var = spawned_count_summer
	# Spring
	elif node_marker == marker_spring:
		spawned_count_var = spawned_count_spring
	# Winter
	elif node_marker == marker_winter:
		spawned_count_var = spawned_count_winter
	# Autumn
	elif node_marker == marker_autumn:
		spawned_count_var = spawned_count_autumn

	for mark in node_marker.get_children():
		if (spawned_count_var <= node_marker.get_child_count()):
			var tree_scene = scene.instantiate()
			get_parent().call_deferred("add_child", tree_scene)
			tree_scene.resource_node_queue_free.connect(_on_resource_queue_free)
			tree_scene.global_position = mark.global_position
			if node_marker == marker_summer:
				spawned_count_summer += 1
			elif node_marker == marker_spring:
				spawned_count_spring += 1
			elif node_marker == marker_winter:
				spawned_count_winter += 1
			elif node_marker == marker_autumn:
				spawned_count_autumn += 1
		
func _on_resource_queue_free(name):
	var node_name = name.to_lower().replace('_', '').replace(' ', '')
	match node_name :
		"coldtree" :
			spawned_count_autumn -= 1
		"orangetree":
			spawned_count_spring -= 1
		"pinktree":
			spawned_count_winter -= 1
		"normaltree":
			spawned_count_spring -= 1
	
	if spawned_count_summer == 0 :
		await get_tree().create_timer(5).timeout
		spawn_resource(marker_summer, tree_summer)
	
	if spawned_count_autumn == 0 :
		await get_tree().create_timer(5).timeout
		spawn_resource(marker_autumn, tree_cold)
	
	if spawned_count_spring == 0 :
		await get_tree().create_timer(5).timeout
		spawn_resource(marker_spring, tree_orange)
	
	if spawned_count_winter == 0 :
		await get_tree().create_timer(5).timeout
		spawn_resource(marker_winter, tree_pink)
		
	
