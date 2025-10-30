extends Node2D

var open = false
var firstOpen = true

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_train_timer_timeout() -> void:
	if(open):
		$trainTimer.wait_time = randf_range(0.1, 2)
		for i in $train/trainCars.get_child_count():
			$train/trainCars.get_child(i).frame = 1
			stopTrain()
			open = false
			firstOpen = false
	else:
		$trainTimer.wait_time = 0.5
		for i in $train/trainCars.get_child_count():
			$train/trainCars.get_child(i).frame = 0
			moveTrain()
			open = true

func moveTrain():
	$train.velocity.x = 1500

func stopTrain():
	$train.velocity.x = 0

func _on_board_butt_pressed() -> void:
	$train.velocity.x = 0
	$trainTimer.stop()
	if(!open and !firstOpen):
		PlayerStats.score += 1
		print(PlayerStats.score)
		for i in $train/trainCars.get_child_count():
			var picture = load("res://assets/graphic/scare/scared.webp")
			var tooAdd = Sprite2D.new()
			tooAdd.texture = picture
			tooAdd.scale = Vector2(0.3,0.3)
			$train/trainCars.get_child(i).add_child(tooAdd)
	$endGameTimer.start()

func _on_end_game_timer_timeout() -> void:
	if(ScreenBus.randomGames and ScreenBus.gamesIdx < ScreenBus.maxGames):
		ScreenBus.nextRandomGame()
	else:
		ScreenBus.changeScene("menu")
