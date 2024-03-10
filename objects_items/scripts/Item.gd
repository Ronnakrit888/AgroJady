extends Resource

class_name Item

@export var display_name : String
@export var icon : Texture2D
@export var texture : Texture2D
@export var maxAmountPrStack : int
@export var value : int 

@export_enum("Common", "Rare", "Epic", "Legendary", "Galaxy")
var rarity : String = "Common"

@export_multiline var description : String


