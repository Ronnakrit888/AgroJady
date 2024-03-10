extends Area2D

class_name InteractionArea

@export var action_name : String = "interact"

var interact : Callable = func():
	pass 
	
signal leave_area

func _on_body_entered(body):
	InteractionManager.register_area(self)

func _on_body_exited(body):
	InteractionManager.unregister_area(self)
	leave_area.emit()
