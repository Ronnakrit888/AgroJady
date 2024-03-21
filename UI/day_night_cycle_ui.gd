extends Control

@onready var day_label_background : Label = $Day/DayLabel
@onready var day_label : Label = $Day/DayLabel/Label
@onready var time_label_background : Label = $Time/TimeLabel
@onready var time_label : Label = $Time/TimeLabel/Label
 
var current_hour: int = 0

func get_hour() -> int:
	return current_hour
	
func set_daytime(day : int, hour : int, minute : int ) :
	day_label.text = str(day + 1)
	
	time_label.text = _amfm_hour(hour) + ":" + _minute(minute) + " " + _am_pm(hour)
	
	current_hour = hour
func _amfm_hour(hour:int) -> String:
	if hour == 0:
		return str(12)
	if hour > 12:
		return str(hour - 12)
	return str(hour)


func _minute(minute:int) -> String:
	if minute < 10:
		return "0" + str(minute)
	return str(minute)


func _am_pm(hour:int) -> String:
	if hour < 12:
		return "am"
	else:
		return "pm"


func _remap_rangef(input:float, minInput:float, maxInput:float, minOutput:float, maxOutput:float):
	return float(input - minInput) / float(maxInput - minInput) * float(maxOutput - minOutput) + minOutput
