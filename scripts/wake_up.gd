extends Node2D

var alarmRinging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$clockTimer.wait_time = randi_range(0,PlayerStats.speed-2)
	$clockTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(alarmRinging):
		$clock.rotation += 3

func _on_clock_timer_timeout() -> void:
	alarmRinging = true
	$clock.position.y -= 30

func _on_wake_butt_pressed() -> void:
	if(alarmRinging):
		PlayerStats.score += 1
		alarmRinging = false
		$person.frame = 1
		$person.flip_h = true
		$person.scale = Vector2(.25,.25)
		$clock.rotation = 0
		$clock.position.y += 30
		$countDown/ProgressBar.value = PlayerStats.speed
		ScreenBus.inGameNextRand()
