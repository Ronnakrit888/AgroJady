extends CharacterBody2D

class_name Player

signal planting
signal healthChanged

@export var speed : float = 100.0
@export var inventory : Inventory
@export var maxHealth : float = 500
@onready var animation = $AnimationPlayer
@onready var previous_direct : String = "right"
@onready var currentHealth : float = maxHealth

var input_movement = Vector2.ZERO
var direction : String
var is_action : bool = false
var mouseLocFromPlayer = null
var have_equip_item : bool = false
var clicked : bool = false
var enemy_inattack_range : bool = false

func player() :
	return

func _physics_process(delta):
	move()
	update_animation()

func update_animation():
	mouseLocFromPlayer = get_global_mouse_position() - self.global_position
	if is_action: return
	
	if velocity.length() == 0:
		animation.play("idle_" + previous_direct)
	else: 
		direction = "right"
		if mouseLocFromPlayer.x < 0: direction = "left"
		
		if mouseLocFromPlayer.x == 0:
			direction = previous_direct
			
		animation.play("walk_" + direction)	
		previous_direct = direction
		
func move():
	input_movement = Input.get_vector("left", "right", "up", "down").normalized()
	
	if input_movement == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = input_movement * speed
	
	if Input.is_action_just_pressed("left click") :
		if have_equip_item :
			action()
	
	if Input.is_action_just_pressed("Planting") :
		emit_signal("planting")
		
	move_and_slide()
	
func action():
	animation.play("action_" + previous_direct)
	is_action = true
	await animation.animation_finished
	is_action = false

func _on_area_detect_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
	
func _on_hand_equip_have_equip_item():
	have_equip_item = true

func _on_hand_equip_no_equip_item():
	have_equip_item = false
