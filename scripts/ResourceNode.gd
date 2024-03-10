extends StaticBody2D

class_name ResourceNode

@export var node_types : Array[ResourceNodeType] 
@export var starting_resource : int = 1
@export var max_resource : int = 1
@export var pickup_type : PackedScene

@onready var animated_sprite = $AnimatedSprite

var current_resources : int :
	set(resource_count):
		current_resources = resource_count
		
		# A resource node emptied of resources is removed from the scene
		if(resource_count <= 0):
			queue_free()
			var random_amount = randi_range(starting_resource, max_resource)
			for n in random_amount:
				spawn_resource()

func _ready():
	current_resources = starting_resource
	animated_sprite.play("full")
	
func _process(delta):
	if current_resources == starting_resource / 2:
		animated_sprite.play("half")
		
func harvest(amount : int):
	current_resources -= amount
	
func spawn_resource():
	if pickup_type:
		var random_pos : float = randf_range(-1.0 , 1.0)
		var pickup_instance : Collectable = pickup_type.instantiate() as Collectable
		pickup_instance.position = position
		
		get_parent().add_child(pickup_instance)
		
		pickup_instance.spawn(pickup_instance.position)
	
