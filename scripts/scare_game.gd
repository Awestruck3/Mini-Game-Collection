extends Node2D

var readyToScare = false

func _ready() -> void:
	$urinalPlayer.z_index = 1
	$Wall.z_index = 2
	$Wall2.z_index = 2
	$scareDoor.z_index = 2
	$playerHands.z_index = 3
	$countDown.z_index = 4
	$countDown.scale.x = 3
	$urinalPlayer.inMovement = false
	$urinalPlayer.inScare = true
	$moveTimer.wait_time = randi_range(0,PlayerStats.speed-2)
	$moveTimer.start()
	

func _on_scarea_area_entered(area: Area2D) -> void:
	readyToScare = true

func _on_scarea_area_exited(area: Area2D) -> void:
	readyToScare = false

func _on_move_timer_timeout() -> void:
	$urinalPlayer.inMovement = true

func _on_scare_butt_pressed() -> void:
	$playerHands/playerHands.frame = 1
	$handResetTimer.start()
	if(readyToScare):
		$urinalPlayer/Mover.frame = 2
		$urinalPlayer.scared = true
		$urinalPlayer.inMovement = false
		PlayerStats.score += 1
		$menuTiemr.start()

func _on_hand_reset_timer_timeout() -> void:
	$playerHands/playerHands.frame = 0

func _on_menu_tiemr_timeout() -> void:
	if(ScreenBus.randomGames and ScreenBus.gamesIdx < ScreenBus.maxGames):
		ScreenBus.nextRandomGame()
	else:
		ScreenBus.changeScene("menu")
