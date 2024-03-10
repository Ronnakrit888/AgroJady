extends CharacterBody2D

@export var speed = 60

@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var damageable = $Damageable

var player_chase = false

func _physics_process(delta):
	if player_chase:
		animated_sprite.play("sidewalk")
		velocity = (player.get_global_position() - position).normalized() * speed * delta
		
	else:
		animated_sprite.play("idle")
		velocity = lerp(velocity, Vector2.ZERO, 0.07)
		
	move_and_collide(velocity)
		
func _on_detetion_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true

func _on_detetion_area_body_exited(body):
	player_chase = false

