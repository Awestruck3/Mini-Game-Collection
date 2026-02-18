extends Node2D

func _ready() -> void:
	$score.text = "Score: %d" % PlayerStats.score
	ScreenBus.gamesIdx = 0
	ScreenBus.shuffleGames()

func _process(delta: float) -> void:
	pass

func _on_mole_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("mole")

func _on_laundry_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("laundry")

func _on_urinal_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("urine")

func _on_random_games_pressed() -> void:
	ScreenBus.randomGames = true
	print(ScreenBus.gamesIdx)
	ScreenBus.nextRandomGame()

func _on_scare_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("scare")

func _on_align_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("align")

func _on_subway_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("subway")

func _on_channel_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("channel")

func _on_crash_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("crash")

func _on_smile_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("smile")

func _on_golf_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("golf")

func _on_job_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("job")

func _on_fast_food_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("fastFood")

func _on_wake_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("wake")

func _on_story_butt_pressed() -> void:
	ScreenBus.randomGames = false
	ScreenBus.changeScene("storyMenu")
