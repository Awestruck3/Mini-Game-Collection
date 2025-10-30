extends CharacterBody2D

var inMovement = true
var rotationVal = -15
var inScare = false
var scared = false

func _ready() -> void:
	
	z_index = 1

func _physics_process(delta: float) -> void:
	if(inMovement):
		if(!inScare):
			velocity.x = 700 / PlayerStats.speed
		else:
			velocity.x = 3000 / PlayerStats.speed
		move_and_slide()
		rotation_degrees += rotationVal
		if(rotation_degrees >= 50):
			rotationVal = -15
		elif(rotation_degrees <= -50):
			rotationVal = 15
	elif(inScare):
		rotation_degrees = 0
		if(!scared):
			$Mover.frame = 0
			$Mover.scale = Vector2(0.28,0.50)
		else:
			$Mover.frame = 2
			$Mover.scale = Vector2(1,1)
	else:
		rotation_degrees = 0
		$Mover.frame = 1
		$Mover.scale = Vector2(0.28,0.50)
