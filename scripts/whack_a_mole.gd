extends Node2D

var moleArr = []

func _ready() -> void:
	if(get_tree().current_scene.name == "whackAMole"):
		var numOfHole = randi_range(3,9)
		for i in numOfHole:
			var newMole = load("res://scenes/mole/mole_hole.tscn")
			var molePos = Vector2(randi_range(0,1000), randi_range(128, 324.5))
			moleArr.append(newMole.instantiate())
			moleArr[i].global_position = molePos
			moleArr[i].scale = Vector2(0.10, 0.10)
			add_child(moleArr[i])
	else:
		var newMole = load("res://scenes/mole/mole_hole.tscn")
		var molePos = Vector2(randi_range(-576,576), randi_range(-190, 300.5))
		var addMole = newMole.instantiate()
		addMole.global_position = molePos
		addMole.scale = Vector2(.10,.10)
		addMole.alt = true
		addMole.altTimer()
		add_child(addMole)
	$countDown.scale = Vector2(3,2)
