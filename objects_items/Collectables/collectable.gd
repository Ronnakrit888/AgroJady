extends Area2D

class_name Collectable

@export var itemRes : Item
var collect_position = 0

func collect(inv : Inventory):
	inv.insert(itemRes)
	
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -12), 0.2)
	tween.tween_property(self, "modulate:a", 0.0, 0.1)
	
	tween.tween_callback(self.queue_free)


func spawn(position):
	collect_position = position
