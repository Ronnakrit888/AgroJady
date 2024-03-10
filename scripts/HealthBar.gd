extends TextureProgressBar

@export var player : Player
@onready var health = $Label

func _ready():
	player.healthChanged.connect(update)
	update()

func update() :
	value = player.currentHealth * 100 / player.maxHealth
	health.text = str(value) + "%"
