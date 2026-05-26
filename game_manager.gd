extends Control


var timer_running = false
var start_time = 0.0
var elapsed_time = 0.0

func _process(delta):
	if timer_running:
		elapsed_time = Time.get_ticks_msec() / 1000.0 - start_time


func start_timer():
	start_time = Time.get_ticks_msec() / 1000.0
	timer_running = true

func reset_timer():
	timer_running = false
	start_time = 0.0
	elapsed_time = 0.0

func stop_timer():
	elapsed_time = Time.get_ticks_msec() / 1000.0 - start_time
	timer_running = false


func get_time_string():
	var minutes = int(elapsed_time / 60)
	var seconds = int(elapsed_time) % 60
	var ms = int((elapsed_time - int(elapsed_time)) * 100)
	return "%02d:%02d:%02d" % [minutes, seconds, ms]
