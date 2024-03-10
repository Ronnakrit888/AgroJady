extends StaticBody2D

var plant = Global.plantselected
var plantgrowing = false
var plant_grown = false


func _ready():
	if plant_grown == true:
			if plant == 1:
				Global.numofplants += 1
				plantgrowing = false
				plant_grown = false
				$crop.play("default")
	else:
		pass
func _physics_process(delta):
	print(Global.plantselected)
	if plantgrowing == false:
		plant = Global.plantselected

func _on_area_2d_area_entered(area):
	if not plantgrowing:
		if plant == 1:
			plantgrowing = true
			$PlantGrowingTimer.start()
			$Plant.play("Plantgrowing")
	else:
		print("plant is already growing here")

func _on_plant_growing_timer_timeout():
	var plant_planted = $plant
	if plant_planted != null:  # Check for null before accessing properties
		if plant_planted.frame == 0:
			plant_planted.frame = 1
			$PlantGrowingTimer.start()
		elif plant_planted.frame == 1:
			plant_planted.frame = 2
			plant_grown = true
			$PlantGrowingTimer.stop()
			if plant_grown == true:
				$Plant.stop()
		if plant_grown:
			$plant.stop()
			queue_free()
			# Activate character movement immediately
			get_parent().get_node("CharacterBody2D").random_movement()

		else:
			print("Error: Plant node not found.")  # Handle the null case appropriately
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
				Global.numofplants += 1
				plantgrowing = false
				plant_grown = false
				$Plant.play("none")
				# Activate character movement
				get_parent().get_node("CharacterBody2D").random_movement()
	else:
		pass

