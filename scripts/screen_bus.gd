extends Node

var randomGames = false
var gamesIdx = 0
var maxGames = 8

var linedUpGames = []

#ALERT update all games every time a mini-game is finished
var allGames = ["mole", "laundry", "urine", "scare", "align", "channel", "subway", "crash"]

func _ready() -> void:
	shuffleGames()

func changeScene(scene: String):
	if(scene == "menu"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
	elif(scene == "mole"):
		get_tree().change_scene_to_file("res://scenes/mole/whack_a_mole_alt.tscn")
	elif(scene == "laundry"):
		get_tree().change_scene_to_file("res://scenes/laundry/laundry.tscn")
	elif(scene == "urine"):
		get_tree().change_scene_to_file("res://scenes/urinal/urinal.tscn")
	elif(scene == "scare"):
		get_tree().change_scene_to_file("res://scenes/scare/scare_game.tscn")
	elif(scene == "align"):
		get_tree().change_scene_to_file("res://scenes/align/align.tscn")
	elif(scene == "channel"):
		get_tree().change_scene_to_file("res://scenes/channelChange/channel_change.tscn")
	elif(scene == "subway"):
		get_tree().change_scene_to_file("res://scenes/subway/subway.tscn")
	elif(scene == "crash"):
		get_tree().change_scene_to_file("res://scenes/carCrash/crash.tscn")

func nextRandomGame():
	print(gamesIdx)
	changeScene(linedUpGames[gamesIdx])
	gamesIdx+=1

func shuffleGames():
	if(!linedUpGames.is_empty()):
		linedUpGames.clear()
	allGames.shuffle() #If I want repeat games I can slip this shuffle function inside the loop
	for i in allGames.size():
		linedUpGames.append((allGames[i]))
	print(allGames)
