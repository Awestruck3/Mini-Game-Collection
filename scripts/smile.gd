extends Node2D
var smiling = false
var moveShutters = false
var bringUp = false

@onready var startTimeMsec = 0
@onready var elapsedTime = 0
@onready var currTime = 0
var accuracy = 0

func _ready() -> void:
	$shutterTimer.wait_time = randi_range(2, PlayerStats.speed-1)
	$shutterTimer.start()
	startTimeMsec = ($shutterTimer.wait_time * 1000) + Time.get_ticks_msec()

func _process(delta: float) -> void:
	currTime = Time.get_ticks_msec()
	elapsedTime = (currTime - startTimeMsec) / 1000
	if(elapsedTime > -0.5 and elapsedTime < -0.3):
		$textCD.text = "3"
	elif(elapsedTime > -0.3 and elapsedTime < -0.1):
		$textCD.text = "2"
	elif(elapsedTime > -0.1 and elapsedTime < -0):
		$textCD.text = "1"
	if(moveShutters):
		if(not bringUp):
			$topShutter.position.y += 100
			$bottomShutter.position.y -= 100
			if($topShutter.position.y >= $bottomShutter.position.y):
				bringUp = true
				checkSmile()
		else:
			$topShutter.position.y -= 100
			$bottomShutter.position.y += 100
			

func checkSmile():
	if($target.frame == 1):
		$accuracyCount.text = "Great!"
		PlayerStats.score += 1
	else:
		if(accuracy < 0):
			$accuracyCount.text = "%f seconds early" % (accuracy * -1)

func _on_smile_butt_pressed() -> void:
	accuracy = elapsedTime
	if(!smiling):
		$target.frame = 1
		$faceResetTimer.start()
		smiling = true

func _on_face_reset_timer_timeout() -> void:
	$target.frame = 0
	$faceRefractory.start()

func _on_face_refractory_timeout() -> void:
	smiling = false

func _on_shutter_timer_timeout() -> void:
	moveShutters = true
	$gameOverTimer.start()

func _on_game_over_timer_timeout() -> void:
	$countDown/ProgressBar.value = PlayerStats.speed
	ScreenBus.inGameNextRand()
