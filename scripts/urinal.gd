extends Node2D

var urinalNPCSpots: Array[Vector2] = [Vector2(-240,66),Vector2(-145,66),Vector2(-49,66),Vector2(48,66),Vector2(144,66),Vector2(248,66)]
var urinalPeople = []
var onPoint = false
var peeingOnSomeone = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_tree().root.content_scale_factor
	for i in randi_range(1,5):
		var newPeer = load("res://scenes/urinal/pee_npc.tscn")
		var instPeer = newPeer.instantiate()
		urinalNPCSpots.shuffle()
		instPeer.global_position = urinalNPCSpots.pop_front()
		add_child(instPeer)
		urinalPeople.append(instPeer)

func _process(delta: float) -> void:
	pass

func _on_pee_butt_pressed() -> void:
	$urinalPlayer.inMovement = false
	for i in urinalPeople.size():
		if(urinalPeople[i].beingPeedOn == true):
			peeingOnSomeone = true
	if(onPoint and peeingOnSomeone == false):
		PlayerStats.score+=1
	$menuTimer.start()

func _on_urinal_area_area_entered(area: Area2D) -> void:
	if(area.name == "ppeeArea"):
		onPoint = true

func _on_urinal_area_area_exited(area: Area2D) -> void:
	if(area.name == "ppeeArea"):
		onPoint = false

func _on_menu_timer_timeout() -> void:
	if(ScreenBus.randomGames and ScreenBus.gamesIdx < ScreenBus.maxGames):
		print(ScreenBus.gamesIdx)
		ScreenBus.nextRandomGame()
	else:
		ScreenBus.changeScene("menu")
