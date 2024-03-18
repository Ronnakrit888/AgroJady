extends Area2D

class_name Collectable

@export var itemRes : Item
@onready var collision_shape = $CollisionShape2D

var launch_vel : Vector2 = Vector2.ZERO 
var time_since_launch : float = 0.0
var move_duration : float = 0.0
var launching : bool = false :
	set(is_launching) :
		launching = is_launching
		
		#collision_shape.disabled = launching
	

func collect(inv : Inventory):
	inv.insert(itemRes)
	
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -12), 0.2)
	tween.tween_property(self, "modulate:a", 0.0, 0.1)
	
	tween.tween_callback(self.queue_free)


func _process(delta):
	if launching :
		position += launch_vel * delta
		time_since_launch += delta
		
		if time_since_launch >= move_duration :
			launching = false

func launch(velo : Vector2, duration : float) :
	launch_vel = velo
	move_duration = duration
	time_since_launch = 0.0
	launching = true
	
