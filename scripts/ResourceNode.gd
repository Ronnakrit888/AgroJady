extends StaticBody2D

class_name ResourceNode

@export var node_types : Array[ResourceNodeType] 
@export var node_name : String 
@export var starting_resource : int = 1
@export var pickup_type : PackedScene
@export var launch_velo : float = 100
@export var launch_time : float = 0.25

@onready var animated_sprite = $AnimatedSprite
@onready var level_parent = get_parent()

signal resource_node_queue_free(String)

var current_resources : int :
	set(resource_count):
		current_resources = resource_count
		
		# A resource node emptied of resources is removed from the scene
		if(resource_count <= 0):
			queue_free()
			emit_signal("resource_node_queue_free", node_name)

func _ready():
	current_resources = starting_resource
	animated_sprite.frame = 0
	
func _process(delta):
	if current_resources == starting_resource / 2:
		animated_sprite.frame = 1
		
func harvest(amount : int):
	for n in range(amount) :
		spawn_resource()
		
	current_resources -= amount
	
func spawn_resource():
	if pickup_type :
		var pickup_instance : Collectable = pickup_type.instantiate() as Collectable
		pickup_instance.position = position
		
		level_parent.call_deferred("add_child", pickup_instance)
		var direction : Vector2 = Vector2(
			randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)
		).normalized()
		
		pickup_instance.launch(direction * launch_velo, launch_time)
	
