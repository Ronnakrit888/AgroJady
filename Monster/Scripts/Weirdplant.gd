extends CharacterBody2D
var speed = 10
var is_sleeping = false
var wait_timer = 0.0
var life_timer = 0.0
var max_life_time = 30.0  # Total lifespan of the character
var animation_delay = 20.0  # Delay before starting the animation

func _ready():
	# Start the life timer when the character is spawned
	life_timer = 0.0

func move_up():
	velocity.y = -speed
	velocity.x = 0
	$AnimatedSprite2D.play("upwalk")

func move_down():
	velocity.y = speed
	$AnimatedSprite2D.play("walk")

func move_left():
	velocity.x = -speed
	velocity.y = 0
	$AnimatedSprite2D.play("Sidewalk")
	$AnimatedSprite2D.scale.x = 1

func move_right():
	velocity.x = speed
	$AnimatedSprite2D.play("Sidewalk")
	$AnimatedSprite2D.scale.x = -1

func sleep():
	velocity.x = 0
	velocity.y = 0
	$AnimatedSprite2D.play("sleep")

func none_animation():
	velocity.x = 0
	velocity.y = 0
	$AnimatedSprite2D.play("none")
	$WaitTimer.start()

func _on_wait_timer_timeout():
	$WaitTimer.stop()
	is_sleeping = false
	random_movement()

func _physics_process(delta):
	life_timer += delta  # Increment the life timer

	if life_timer >= max_life_time:
		queue_free()  # Remove the character from the scene when the time is up
	elif life_timer >= animation_delay:
		if randf() < 0.01:
			random_movement()

		move_and_slide()

func random_movement():
	var random_direction = randi() % 4

	match random_direction:
		0:
			move_up()
		1:
			move_down()
		2:
			move_left()
		3:
			move_right()
