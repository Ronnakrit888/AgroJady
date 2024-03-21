extends Node2D

@onready var enemy_scene = preload("res://Monster/Scenes/enemy.tscn")
var spawned : bool = false
var spawned_count : int = 0
func _ready():
	print("Ready")

func _process(delta):
	print(Global.hour)
	if Global.hour >= 18 :
		spawner()
		return
		
	if Global.hour >= 4 :
		spawned = false
		remove()
			
func spawner():
	for mark in get_children() :
		if spawned_count < 5 :
				var enemy = enemy_scene.instantiate()
				get_node("Enemy").call_deferred("add_child", enemy)
				enemy.position = mark.global_position
				spawned_count += 1
				
							
		
func remove():
	for child in get_node("Enemy").get_children() :
		spawned_count = 0
		child.queue_free()
