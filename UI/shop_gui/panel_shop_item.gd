extends NinePatchRect

@export var item : ShopItemData

@onready var itemIcon = $MarginContainer/ItemIcon
@onready var itemName = $Name
@onready var priceShow = $BuyButton/Price

func _ready() :
	#if !item :
		#return
	
		
	#itemIcon.texture = item.item.icon
	#itemName.text = item.item.display_name
	#priceShow.text = str(item.item.value)
	pass
	
	
