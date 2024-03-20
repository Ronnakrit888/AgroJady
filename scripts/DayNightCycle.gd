extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick(day:int, hour:int, minute:int)

@export var gradient_texture : GradientTexture1D
@export var INGAME_SPEED = 20.0
@export var INITIAL_HOUR = 12:
	set(h):
		INITIAL_HOUR = h
		Global.time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR


var past_minute:int= -1


func _ready() -> void:
	if (Global.time == 0.0) :
		Global.time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR

func _process(delta: float) -> void:
	if gradient_texture != null : 
		Global.time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED

		var value = (sin(Global.time - PI / 2.0) + 1.0) / 2.0
		self.color = gradient_texture.gradient.sample(value)
		
	_recalculate_time()	
	print(Global.hour)

		
func _recalculate_time() -> void:
	var total_minutes = int(Global.time / INGAME_TO_REAL_MINUTE_DURATION)
	
	var day = int(total_minutes / MINUTES_PER_DAY)

	var current_day_minutes = total_minutes % MINUTES_PER_DAY

	Global.hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, Global.hour, minute)
