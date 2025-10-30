extends Control

func _ready() -> void:
	$ProgressBar.value = PlayerStats.speed
	$ProgressBar.max_value = PlayerStats.speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($ProgressBar.value == 0):
		$countDownTimer.stop()
		if(ScreenBus.randomGames and ScreenBus.gamesIdx < ScreenBus.maxGames):
			ScreenBus.nextRandomGame()
		else:
			ScreenBus.changeScene("menu")


func _on_count_down_timer_timeout() -> void:
	$ProgressBar.value -= 1
