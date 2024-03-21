extends Node2D

var tree_scenes = {
	"Summer": preload("res://scenes/resourec_node/resource_node_tree_summer.tscn"),
	"Spring": preload("res://scenes/resourec_node/resource_node_tree_orange.tscn"),
	"Winter": preload("res://scenes/resourec_node/resource_node_tree_pink.tscn"),
	"Autumn": preload("res://scenes/resourec_node/resource_node_tree_cold.tscn")
	}

var spawned_counts = {
	"Summer" : 0,
	"Spring" : 0,
	"Autumn" : 0,
	"Winter" : 0
	}
	

func _ready():
	for marker_name in tree_scenes.keys():
		spawn_resource(get_node(marker_name), tree_scenes[marker_name])
	
func spawn_resource(marker, scene):
	var spawned_count = spawned_counts[marker.name]
	for mark in marker.get_children() :
		if spawned_count < marker.get_child_count() :
			var tree_scene = scene.instantiate()
			get_parent().call_deferred("add_child", tree_scene)
			tree_scene.resource_node_queue_free.connect(_on_resource_queue_free)
			tree_scene.global_position = mark.global_position
			spawned_counts[marker.name] += 1

func _on_resource_queue_free(name) :
	var node_name = name.to_lower().replace("_", "").replace(" ", "")
	for season in tree_scenes.keys() :
		if node_name == season.to_lower():
			spawned_counts[season] -= 1
			
		if spawned_counts[season] == 0:
			_spawn_tree_delayed(season)
		
func _spawn_tree_delayed(season) :
	var marker = get_node(season)
	var tree_scene = tree_scenes[season]
	await get_tree().create_timer(5).timeout
	spawn_resource(marker, tree_scene)
	
