extends CharacterBody2D

class_name Enemy

@export var speed = 60
@export var types : Array[ResourceNodeType]
#
@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var enemy_collect :bool = false
@onready var animated_sprite = $AnimatedSprite2D
@onready var damage_numbers_origin = $DamageNumberOrigin


@export var itemRes: Inventory

var health = 100
var damage 
var player_chase = false
var dead = false

func _ready():
	dead = false
	
func _physics_process(delta):
	if  !dead:
		$detetion_area/CollisionShape2D.disabled = false
		if player_chase:
			animated_sprite.play("sidewalk")
			var direction = player.get_global_position() - global_position
			velocity = direction.normalized() * speed * delta
			
			if direction.x < 0:  # Player is to the left
				animated_sprite.scale.x = -1
			elif direction.x > 0:  # Player is to the right
				animated_sprite.scale.x = 1
				
		else:
			animated_sprite.play("idle")
			velocity = lerp(velocity, Vector2.ZERO, 0.07)
			
		move_and_collide(velocity)
		
	if dead:
		$detetion_area/CollisionShape2D.disabled = true
		if not enemy_collect:
			pass
	
				
func _on_detetion_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true

func _on_detetion_area_body_exited(body):
	if body.has_method("player"):
		player_chase = false

#func _on_hitbox_area_entered(body):
	#
	#if body.has_method("player"):
func enemy():
	pass		
		
func take_damage(damage: int) -> void:
	health -= damage
	#var is_critical = damage.crit_chance >randf()
	DamageNumbers.display_number(damage, damage_numbers_origin.global_position, false)
	#await animated_sprite.animation_finished
	
	if health <= 0 and not dead:
		print("death")
		death()
		dead = true  # Set flag to prevent repeated death handling
	# Handle injury animation (optional)
	if health <= 100 and not dead:
		print("hurt")
		hurt()
		animated_sprite.play("death")
		await get_tree().create_timer(1).timeout
#
#func _on_hitbox_area_entered(body):
	#for child in body.get_children():
		#if child is damageable:
			#child.take_damage(damage)
			#print_debug(body.name + "took"+ str(dama	ge) + ".")	
		#
		
func hurt():
	animated_sprite.play("hurt")
	await get_tree().create_timer(1).timeout
	
		
		
func death():
	dead = true
	animated_sprite.play("death")
	
	await get_tree().create_timer(1).timeout
	queue_free()
	
	#drop_enemy()


	#$hitbox/CollisionShape2D.disabled = true
	$detetion_area/CollisionShape2D.disabled = true
	
	
	
	
	
#func drop_enemy():
	#pass
	#
	#enemy_collect()
	#

	
#func enemy_collect():
	#await get_tree().create_timer(3).timeout
	##enemies.visible = false
	##player.has_method("_on_area_detect_area_entered")
	#queue_free()
	


