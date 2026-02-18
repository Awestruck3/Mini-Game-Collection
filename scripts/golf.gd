extends Node2D

var arrowMove = true
var ballHit = false
var arrowMoveDown = true
var clubComeDown = false

func _physics_process(delta: float) -> void:
	if(arrowMove):
		if(arrowMoveDown):
			$arrow.rotation_degrees += 3
			if($arrow.rotation_degrees > 40):
				arrowMoveDown = false
		else:
			$arrow.rotation_degrees -= 3
			if($arrow.rotation_degrees < -40):
				arrowMoveDown = true
	if(ballHit):
		swingAni()

func swingAni():
	if(!clubComeDown):
		$club.rotation_degrees += 4
		if($club.rotation_degrees >= 40):
			clubComeDown = true
	if(clubComeDown):
		$club.rotation_degrees -= 20
		if($club.rotation_degrees <= -45):
			$club.position += Vector2(-2,-2)
			var velox = $arrow.rotation + 1 * 1000 #TECHNICALLY this means the ball goes faster if the arrow is pointing down but it's minimal
			var veloy = $arrow.rotation * 1000
			#ballHit = false
			if($arrow.rotation < 0):
				veloy += 100
			$ball.velocity.x = velox
			$ball.velocity.y = veloy

func _on_swing_butt_pressed() -> void:
	ballHit = true
	arrowMove = false

func _on_golf_hole_end_game() -> void:
	PlayerStats.score += 1
	if(ScreenBus.randomGames and ScreenBus.gamesIdx < ScreenBus.maxGames):
		ScreenBus.nextRandomGame()
	else:
		ScreenBus.changeScene("menu")
