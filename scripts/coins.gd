extends TextureRect

@onready var label = $Label

func _ready():
	Global.gained_coin.connect(update_coin)
	Global.removed_coin.connect(update_coin)
	
	
func update_coin(coins):
	label.text = str(coins)
