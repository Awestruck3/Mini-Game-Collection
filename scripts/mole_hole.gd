extends Node2D

var alt = false

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func altTimer():
	$moleSwapTimer.wait_time = randi_range(0,PlayerStats.speed - 1)
	$moleSwapTimer.start()
	$moleHoleSprite.frame = 0

func resetAltTimer():
	$moleSwapTimer.stop()
	$moleHoleSprite.frame = 0

func _on_mole_swap_timer_timeout() -> void:
	if(alt == false):
		var moleShow = randi_range(1,5)
		if (moleShow > 3):
			toggleMole()
	else:
		toggleMole()
		#$moleSwapTimer.stop()
		$altTimer.start()

func toggleMole():
	if($moleHoleSprite.frame == 0):
		$moleHoleSprite.frame = 1
	else:
		$moleHoleSprite.frame = 0

func _on_hit_mole_pressed() -> void:
	if(!alt):
		if($moleHoleSprite.frame == 1):
			PlayerStats.score += 1
			$moleHoleSprite.frame = 0
	else:
		if($moleHoleSprite.frame == 1):
			PlayerStats.score += 1
			$moleHoleSprite.frame = 0
			if(ScreenBus.randomGames and ScreenBus.gamesIdx < ScreenBus.maxGames):
				var cd = get_parent().get_node("countDown/ProgressBar")
				print(cd.value)
				cd.value = PlayerStats.speed
				ScreenBus.nextRandomGame()
			else:
				ScreenBus.changeScene("menu")


func _on_alt_timer_timeout() -> void:
	$moleHoleSprite.frame = 0
