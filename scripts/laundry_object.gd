extends CharacterBody2D

var slideRight = true
var isThrown = false
var comingDown = false

func _physics_process(delta: float) -> void:
	move_and_slide()
	if(!isThrown):
		if(slideRight == true):
			velocity.x = 3000 / PlayerStats.speed
			if(position.x >= 185):
				slideRight = false
		else:
			velocity.x = -(3000 / PlayerStats.speed)
			if(position.x <= -185):
				slideRight = true
	else:
		scale = lerp(Vector2(scale.x, scale.y),Vector2(.1,.1),delta * 5)
		if(position.y <= -128):
			comingDown = true
			velocity.y = 5000 / PlayerStats.speed
		elif(position.y >= 96 and comingDown):
			velocity = Vector2(0,0)
