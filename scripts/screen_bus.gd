extends Node

var randomGames = false
var story = false
var gamesIdx = 0
var maxGames = 13

var linedUpGames = []

var transAnimation = false

#ALERT update all games every time a mini-game is finished
var allGames = []

func _ready() -> void:
	readJSON()
	shuffleGames()

func _physics_process(delta: float) -> void:
	if(transAnimation):
		$transSprite.scale = lerp($transSprite.scale, Vector2(10,10),10 * delta)

func changeScene(scene: String):
	if(story or scene != "storyMenu"):
		screenChangeAni()
		var timeoutCall = Callable(self,"_on_trans_time_timeout")
		var timeoutWithArg = timeoutCall.bind(scene)
		var transTime = Timer.new()
		transTime.wait_time = 1
		transTime.one_shot = true
		add_child(transTime)
		transTime.connect("timeout", timeoutWithArg)
		transTime.start()
	elif (scene == "storyMenu"):
		get_tree().change_scene_to_file("res://scenes/story_menu.tscn")
	else:
		get_tree().change_scene_to_file(scene)

func _on_trans_time_timeout(scene:String):
	transAnimation = false
	remove_child($transSprite)
	#if(scene == "menu"):
		#get_tree().change_scene_to_file("res://scenes/menu.tscn")
	if(scene == "storyMenu"):
		get_tree().change_scene_to_file("res://scenes/story_menu.tscn")
	else:
		var masterList = FileAccess.open("res://scripts/scenesMasterList/masterlist.json", FileAccess.READ)
		var listAsText = masterList.get_as_text()
		var parsedList = JSON.parse_string(listAsText)
		var tscn = "res://scenes/menu.tscn"
		for i in parsedList.scenes:
			if(i.scene == scene):
				tscn = i.tscn
		get_tree().change_scene_to_file(tscn)

func screenChangeAni():
	var transSprite = Sprite2D.new()
	transSprite.texture = load("res://assets/graphic/icon.svg")
	transSprite.scale = Vector2(0,0)
	transSprite.z_index = 10
	transSprite.name = "transSprite"
	add_child(transSprite)
	transAnimation = true

func nextRandomGame():
	changeScene(linedUpGames[gamesIdx])
	gamesIdx+=1

func shuffleGames():
	if(!linedUpGames.is_empty()):
		linedUpGames.clear()
	allGames.shuffle() #If I want repeat games I can slip this shuffle function inside the loop
	for i in allGames.size():
		linedUpGames.append((allGames[i]))

func inGameNextRand():
	if(randomGames and gamesIdx < maxGames-1):
		nextRandomGame()
	else:
		changeScene("menu")

func readJSON():
	var file = FileAccess.open("res://scripts/scenesMasterList/masterlist.json", FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(json_string)
	for i in parsed.scenes:
		if(i.scene != "menu"):
			allGames.append(i.tscn)
	allGames.shuffle()
