extends CharacterBody2D

class_name Enemy

@export var speed = 1
@export var types : Array[ResourceNodeType]
@export var damage : int = 30
 
@onready var damage_number_origin = $DamageNumberOrigin
@onready var detect_shape = $detetion_area/detect_shape
@onready var attack_shape = $attackPoint/attack_shape
@onready var collision_body = $CollisionShape2D
@onready var attack_point = $attackPoint
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D

var health : float = 100
var player_chase : bool = false
var dead : bool = false
var in_attack_range : bool = false
var got_hit : bool = false
var direction 
var player 

signal attack_damage(damage)

func _ready():
	dead = false
	animation_player.play("idle")
	
func _physics_process(delta):
	if !dead && player :
		
		if player_chase :
			direction = position.direction_to(player.position)
			animation_player.play("walk")
			if abs(direction.angle()) > PI / 2 :
				sprite.flip_h = true
				attack_point.rotate(PI)
			else :
				sprite.flip_h = false
				attack_point.rotate(PI)
				
			velocity = direction * speed
			
			move_and_collide(velocity)
			
		else :
			animation_player.play("idle")
		

# Detect Player in Area
func _on_detetion_area_body_entered(body):
	if body.has_method("player") :
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
			
			var tween = create_tween()
			tween.tween_property(self, "modulate:a", 0.0, 1.5)
	
			tween.tween_callback(self.queue_free)
	
	DamageNumbers.display_number(damage, damage_number_origin.global_position, false)

