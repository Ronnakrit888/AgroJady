extends TextureRect

@onready var iconTexture = $MarginContainer/TextureRect
@onready var iconName = $MarginContainer/TextureRect/Label


func set_item_info(item_texture : Texture2D, item_name : String) -> void :
	iconTexture.texture = item_texture
	set_label(item_name)

func set_label(value) -> void :
	iconName.text = str(value)
	

