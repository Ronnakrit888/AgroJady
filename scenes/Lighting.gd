extends PointLight2D

func _process(delta):
	var hour = Global.hour
	
	if hour >= 18 or hour <= 4:
		self.visible = true
		create_tween().set_ease(Tween.EASE_IN).tween_property(
			self, "texture_scale", 0.15, 1.0)
	else :
		create_tween().set_ease(Tween.EASE_IN).tween_property(
			self, "texture_scale", 0.01, 1.0)
		self.visible = false
