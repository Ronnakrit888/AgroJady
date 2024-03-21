extends CharacterBody2D

class_name Enemy

@export var speed = 60
@export var types : Array[ResourceNodeType]

@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var damage_number_origin = $DamageNumberOrigin
@onready var detection_area_shape = $detetion_area/CollisionShape2D
@onready var attack_area_shape = $attackPoint/CollisionShape2D
@onready var collision_body = $CollisionShape2D

var health : float = 100
var damage
var player_chase : bool = false
var dead : bool = false
var in_attack_range : bool = false
var direction 

func _ready():
	dead = false
	attack_area_shape.disabled = true
	animated_sprite.play("idle")
	
func _physics_process(delta):
	if !dead :
		direction = global_position.direction_to(player.global_position)
		animated_sprite.play("sidewalk")
		if abs(direction.angle()) > PI / 2 :
			animated_sprite.flip_h = true
		else :
			animated_sprite.flip_h = false
		
		velocity = direction * speed
		
		move_and_collide(velocity)


func _on_detetion_area_body_entered(body):
	if body.has_method("player") :
		player = body
		player_chase = true


func _on_detetion_area_body_exited(body):
	if body.has_method("player") :
		player_chase = false

func take_damage(damage : int ) -> void :
	health -= damage
	DamageNumbers.display_number(damage, damage_number_origin.global_position, false)
	
	if !dead :
		if health <= 100:
			hurt()
			return
			
		if health <= 0:
			death()
			

func hurt() :
	animated_sprite.play("hurt")
	await animated_sprite.animation_finished
	
func death() :
	dead = true
	collision_body.call_deferred("disabled", true)
	animated_sprite.play("death")
	
	var tween = get_tree().create_tween()
	tween.tween_property(animated_sprite, "position:y", 3, 0.5)
	var timer = get_tree().create_timer(2).timeoutd
	

func _on_attack_point_body_entered(body):
	if body.has_method("player"):
		player = body
		in_attack_range = true
		attack_area_shape.disabled = true

func _on_attack_point_body_exited(body):
	if body.has_method("player"):
		body = null
		in_attack_range = false
		attack_area_shape.disabled = false
