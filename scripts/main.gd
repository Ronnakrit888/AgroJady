extends Node2D

@onready var canvas_modulate = $CanvasModulate
@onready var tileMap : TileMap = $TileMap
@onready var player : Player = $TileMap/player
@onready var grid_helper = $TileMap/GridHelper
@onready var gui = $GUI
@onready var day_time_ui = $GUI/DayNightCycleUI
#@onready var enemy_scene = preload("res://Monster/Scenes/enemy.tscn")



var currentSeed : PlantData
var enemy_instance: Node2D

const GRID_SIZE = 16

var plants : Dictionary = {}

func _ready() :
	
	canvas_modulate.time_tick.connect(day_time_ui.set_daytime)
	grid_helper.visible = false
	Global.seed_changed.connect(_on_seed_changed)
	gui.setup_hotbar_seed()
	#enemy_instance = enemy.instance()
	#_enemy_spawn()
	

	
func _on_inventory_gui_closed():
	get_tree().paused = false

func _on_inventory_gui_opened():
	get_tree().paused = true
	
func _physics_process(_delta):
	
	
	var playerMapCoord = tileMap.local_to_map(player.position)
	var mouse_position = Vector2i(get_global_mouse_position() / GRID_SIZE ) * GRID_SIZE
	grid_helper.position = playerMapCoord * GRID_SIZE
	
	var cellLocalCoord = tileMap.local_to_map(grid_helper.position)
	var tile : TileData = tileMap.get_cell_tile_data(1, cellLocalCoord)
	
	if tile == null :
		grid_helper.visible = false
		return
		
	if tile.get_custom_data("HoedLand") :
		grid_helper.visible = true
		


func _on_player_planting():
	var cellLocalCoord = tileMap.local_to_map(grid_helper.position)
	var tile : TileData = tileMap.get_cell_tile_data(1, cellLocalCoord)
	
	if tile == null or currentSeed == null :
		return
	
	if tile.get_custom_data("Spring") :
		var plantCoord = tileMap.local_to_map(grid_helper.global_position)
		if not plants.has(plantCoord) : 
			if currentSeed.get_type() == "Spring":
				if currentSeed.seed_left() :
					currentSeed.substract_amount()
					_plant_seed(plantCoord)
				else :
					gui.hotbar_slot_empty(currentSeed)
				
		if is_harvestable(plantCoord) :
			harvest_plant(plantCoord)

func harvest_plant(key) -> void :
	var plant = plants.get(key)
	if plant.has_method("harvest") :
		plant.harvest()
		plants.erase(key)
		
func is_harvestable(key) -> bool :
	var data = plants.get(key)
	return data.harvest_ready if data != null else false
		
func _plant_seed(coord) -> void :
	var plant = currentSeed.plantScene.instantiate()
	get_node("TileMap/Plant").add_child(plant)
	
	plants[coord] = plant
	plant.global_position = tileMap.map_to_local(coord)
	

func _on_seed_changed(new_seed) -> void : 
	currentSeed = new_seed

#func _enemy_spawn():
	#if day_time_ui.has_method("get_hour"):
		#var hour = day_time_ui.get_hour()
		#if hour == 5 and enemy_instance != null:
			#enemy_instance.queue_free()
		#elif hour == 20 and enemy_instance == null:
			#enemy_instance = enemy.instance()
			#get_node("Monster").add_child(enemy_instance)



#func _on_timer_timeout():
	#var enemy = enemy_scene.instantiate()
	#add_child(enemy)
	#print("1")
