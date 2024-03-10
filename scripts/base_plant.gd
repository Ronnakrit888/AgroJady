extends Node2D

class_name Plant

@export var amount : int = 1
@export var plantItem : PackedScene
@export var harvest_ready : bool = false

@onready var plant_sprite = $AnimationPlayer
@onready var level_parent = get_parent()

var index = 0

func _ready():
	plant_sprite.play(str(index))
	
func _on_timer_timeout():
	index += 1
	plant_sprite.play(str(index))

func harvest() -> void :
	for n in amount :
		spawn_item()
	queue_free()

func spawn_item() :
	var collect_instance : Collectable = plantItem.instantiate() as Collectable
	level_parent.add_child(collect_instance)
	collect_instance.position = position
