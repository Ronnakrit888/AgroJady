extends CharacterBody2D

class_name Enemy

@export var speed = 1
@export var types : Array[ResourceNodeType]
 
@onready var animated_sprite = $AnimatedSprite2D
@onready var damage_number_origin = $DamageNumberOrigin
@onready var detect_shape = $detetion_area/detect_shape
@onready var attack_shape = $attackPoint/attack_shape
@onready var collision_body = $CollisionShape2D
@onready var popup = $Popup
@onready var popup_scene = preload("res://UI/pop_up.tscn")
@onready var attack_point = $attackPoint

var health : float = 100
var player_chase : bool = false
var dead : bool = false
var in_attack_range : bool = false
var got_hit : bool = false
var direction 
var player 

func _ready():
	dead = false
	attack_shape.disabled = true
	animated_sprite.play("idle")
	
func _physics_process(delta):
	if !dead && player :
		
		if player_chase :
			direction = position.direction_to(player.position)
			animated_sprite.play("sidewalk")
			if abs(direction.angle()) > PI / 2 :
				animated_sprite.flip_h = true
				attack_point.rotate(PI)
			else :
				animated_sprite.flip_h = false
				attack_point.rotate(0)
				
			velocity = direction * speed
			
			move_and_collide(velocity)
			
		else :
			animated_sprite.play("idle")



# Detect Player in Area
func _on_detetion_area_body_entered(body):
	if body.has_method("player") :
		PopUpDisplay.display_popup(popup_scene, popup.global_position)
		player = body
		player_chase = true

func _on_detetion_area_body_exited(body):
	if body.has_method("player") :
		player_chase = false

func take_damage(damage : int ) -> void :
	if !dead :
		health -= damage
		if health <= 0 :
			health == 0
			death()
	
	DamageNumbers.display_number(damage, damage_number_origin.global_position, false)
	
func hurt() :
	animated_sprite.play("hurt")
	await animated_sprite.animation_finished
	
func death() :
	dead = true
	collision_body.call_deferred("disabled", true)
	animated_sprite.play("death")
	
	var tween = get_tree().create_tween()
	tween.tween_property(animated_sprite, "position:y", 3, 0.5)
	var timer = get_tree().create_timer(2).timeout
	

func _on_attack_point_body_entered(body):
	if body.has_method("player"):
		player = body
		in_attack_range = true
		attack_shape.disabled = false
		attack_shape.visible = true

func _on_attack_point_body_exited(body):
	if body.has_method("player"):
		body = null
		in_attack_range = false
		attack_shape.disabled = true
		attack_shape.visible = false
