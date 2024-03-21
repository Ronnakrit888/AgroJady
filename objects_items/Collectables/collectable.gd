extends Area2D

class_name Collectable

@export var itemRes : Item
var collect_position = 0

func collect(inv : Inventory):
	inv.insert(itemRes)
	queue_free()

func spawn(position):
	collect_position = position


