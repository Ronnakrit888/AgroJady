extends Node

func display_popup(pop_up_scene, position):
	var pop_up = pop_up_scene.instantiate()
	pop_up.position = position
	
	call_deferred("add_child", pop_up)
	
	var tween = create_tween()
	tween.tween_property(pop_up, "position:y", pop_up.position.y - 24, 0.05).set_ease(Tween.EASE_OUT)
	
