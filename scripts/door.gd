extends StaticBody2D

@onready var door_anim = $AnimationPlayer

func _ready():
	door_anim.play("close")
