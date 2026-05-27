extends Control

var timer_running := false
var timer_started := false

var start_time := 0.0
var elapsed_time := 0.0


func _process(delta):
	if timer_running:
		elapsed_time = Time.get_ticks_msec() / 1000.0 - start_time


func start_timer():
	if timer_started:
		return

	timer_started = true
	timer_running = true

	start_time = Time.get_ticks_msec() / 1000.0
	elapsed_time = 0.0

func stop_timer():
	if timer_running:
		elapsed_time = Time.get_ticks_msec() / 1000.0 - start_time
		timer_running = false

func reset_timer():
	timer_running = false
	timer_started = false

	start_time = 0.0
	elapsed_time = 0.0

func get_time_string() -> String:
	var minutes = int(elapsed_time / 60)
	var seconds = int(elapsed_time) % 60
	var ms = int((elapsed_time - int(elapsed_time)) * 100)

	return "%02d:%02d:%02d" % [minutes, seconds, ms]
