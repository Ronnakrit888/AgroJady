extends Node2D

class_name BaseScene

@onready var player : Player = $Player
@onready var entrance_markers : Node2D = $EntranceMarkers

func _ready():
	if scene_manager.player :
		if player :
			player.queue_free()
			
		player = scene_manager.player
		add_child(player)

	pos_player()

func pos_player() -> void :
	for entrance in entrance_markers.get_children() :
		if entrance is Marker2D and entrance.name == "any" :
			player.global_position = entrance.global_position
