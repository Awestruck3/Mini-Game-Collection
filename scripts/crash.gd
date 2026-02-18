extends Node2D

var brake = false
var comingDown = false
var personShowing = false
var hit = false
var endG = false

func _ready() -> void:
	$personTimer.wait_time = randf_range(0, PlayerStats.speed - 2)
	$personTimer.start()

func _process(delta: float) -> void:
	if(!brake and !hit):
		checkHit()
		shake()
		if(personShowing):
			scale(delta)
	elif(hit and !endG):
		$person.scale = lerp(Vector2($person.scale.x, $person.scale.y), Vector2(.01,.01), 10 * delta)
		$person.position += Vector2(1,-10)
		$person.rotation_degrees += 15
	elif(brake and !endG):
		if(personShowing):
			$person.texture = load("res://assets/graphic/carCrash/win.jpg")
			$person.scale = Vector2(1,1)
			PlayerStats.score += 1
		$moveTimer.start()
		endG = true

func shake():
	if(!comingDown):
		$Camera2D.position.y -= 2
		if($Camera2D.position.y < -5):
			comingDown = true
	else:
		$Camera2D.position.y += 2
		if($Camera2D.position.y > 5):
			comingDown = false

func _on_person_timer_timeout() -> void:
	$person.show()
	personShowing = true

func scale(delta):
	$person.scale = lerp(Vector2($person.scale.x, $person.scale.y), Vector2(.8,.8), 1 * delta)
	#print($person.scale)

func checkHit():
	if($person.scale >= Vector2(0.27, 0.27)):
		hit = true
		$moveTimer.start()

func _on_stop_butt_pressed() -> void:
	brake = true

func _on_move_timer_timeout() -> void:
	$countDown/ProgressBar.value = PlayerStats.speed
	ScreenBus.inGameNextRand()
	#if(ScreenBus.randomGames and ScreenBus.gamesIdx < ScreenBus.maxGames):
		#ScreenBus.nextRandomGame()
	#else:
		#ScreenBus.changeScene("menu")
