extends TextureRect

@onready var item_texture = $MarginContainer/TextureRect
@onready var item_amount = $MarginContainer/TextureRect/Label
@onready var item_flashing = $AnimationPlayer

func set_item_info(item_icon : Texture, value) -> void :
	set_icon(item_icon)
	set_label(value)
	
func set_label(value) -> void :
	item_amount.text = str(value)

func play_flash_animation() -> void :
	item_flashing.play("flash")

func set_icon(item_icon : Texture2D) -> void :
	item_texture.texture = item_icon
