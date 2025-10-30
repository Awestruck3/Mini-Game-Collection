extends Node2D

var currentChannel = 0
var goalChannel = randi_range(5, (PlayerStats.speed * 10 / 3))
var channelNum = (PlayerStats.speed * 10 / 3)

func _ready() -> void:
	print(goalChannel)
	print(channelNum)
	pass # Replace with function body.

func _process(delta: float) -> void:
	if(currentChannel == goalChannel):
		$static.play("gotit")
		$static.scale = Vector2(0.75,0.75)
	else:
		$static.scale = Vector2(4.053,2.786)
	if($countDown/ProgressBar.value == 0 and currentChannel == goalChannel):
		PlayerStats.score += 1
		print(PlayerStats.score)

func _on_chup_pressed() -> void:
	currentChannel = currentChannel%(channelNum) + 1
	print(currentChannel)
	$static.show()
	$static.play("default")

func _on_chdn_pressed() -> void:
	if(currentChannel == 0): #Unhappy with this but the mod thing didn't work into negatives 
		currentChannel = (channelNum)
		print(currentChannel)
	else:
		currentChannel -= 1
		print(currentChannel)
	$static.show()
	$static.play("default")
