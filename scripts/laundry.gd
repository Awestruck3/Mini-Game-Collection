extends Node2D

const gravity = 100

var slideRight = true
var hasLaundry = false
var laundArray = []
var laundIdx = 0

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	if(slideRight == true):
		$playerHands.velocity.x = 3000 / PlayerStats.speed
		if($playerHands.position.x >= 185):
			slideRight = false
	else:
		$playerHands.velocity.x = -(3000 / PlayerStats.speed)
		if($playerHands.position.x <= -185):
			slideRight = true
	$playerHands.move_and_slide()
	if(Input.is_action_just_pressed("LMB") and hasLaundry):
		throw()
		$reset.start()
		

func throw():
	$playerHands/playerHands.frame = 1
	hasLaundry = false
	laundArray[laundIdx].isThrown = true
	laundArray[laundIdx].velocity = Vector2($playerHands.velocity.x/50, -(5000 / PlayerStats.speed))
	laundIdx+=1

func _on_reset_timeout() -> void:
	$playerHands/playerHands.frame = 0

func _on_reload_area_body_entered(body: Node2D) -> void:
	if(hasLaundry == false):
		var nl = load("res://scenes/laundry/laundry_object.tscn")
		var newLaundry = nl.instantiate()
		var laundryArea = Area2D.new()
		var laundryShape = CollisionShape2D.new()
		var newLaundryText : Texture2D = load("res://assets/graphic/laundryToss/laundry.jpeg")
		var newLaundrySprite = Sprite2D.new()
		var newShape = RectangleShape2D.new()
		laundryArea.name = "laundryArea"
		newShape.extents = Vector2(50,100)
		laundryShape.shape = newShape
		newLaundrySprite.texture = newLaundryText
		laundryArea.z_index = 10
		laundryArea.add_child(laundryShape)
		laundryArea.set_collision_layer_value(0, true)
		laundryArea.set_collision_mask_value(1, true)
		newLaundry.add_child(laundryArea)
		newLaundry.add_child(newLaundrySprite)
		add_child(newLaundry)
		newLaundry.scale = Vector2(.25,.25)
		newLaundry.global_position = $playerHands.global_position
		newLaundry.velocity = $playerHands.velocity
		newLaundry.move_and_slide()
		laundArray.append(newLaundry)
		hasLaundry = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.name == "laundryArea"):
		if(area.get_parent().comingDown == true):
			PlayerStats.score += 1
			if(ScreenBus.randomGames == true):
				ScreenBus.nextRandomGame()
			else:
				ScreenBus.changeScene("menu")
