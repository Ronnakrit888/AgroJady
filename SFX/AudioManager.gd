extends Node

func play_sound(stream : AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	instance.finished.connect(_sound_finished.bind(instance))
	add_child(instance)
	instance.play()

func _sound_finished(instance : AudioStreamPlayer) :
	instance.queue_free()

