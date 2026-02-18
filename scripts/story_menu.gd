extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_full_games_butt_pressed() -> void:
	ScreenBus.changeScene("menu")

func _on_story_butt_pressed() -> void:
	ScreenBus.story = true
	ScreenBus.changeScene("res://scenes/wakeUp/wake_up.tscn")
