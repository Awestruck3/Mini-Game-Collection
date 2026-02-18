extends Node2D

var foodNames = {0:"ayamGor",1:"stirFry",2:"burger",3:"fries",4:"pizza",5:"sandwich",6:"hotdog"}
var chosenFoods = []
var allFoods = []
var itemHeld : bool = false
var selectedItem = null

var peopleServed: int = 0

func _ready() -> void:
	$countDown/ProgressBar.value = PlayerStats.speed
	
	prepAllFoods()
	prepMenuItems()
	for i in $peopleGroup.get_child_count():
		var newTime = Timer.new()
		$bubbles.get_child(i).hide()
		$ideaFood.get_child(i).hide()
		newTime.wait_time = randi_range(0, PlayerStats.speed - 2)
		newTime.one_shot = true
		newTime.connect("timeout", on_new_time_timeout.bind($peopleGroup.get_child(i), $bubbles.get_child(i), $ideaFood.get_child(i)))
		$peopleGroup.get_child(i).add_child(newTime)
		newTime.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(selectedItem != null and Input.is_action_just_released("LMB")):
		selectedItem = null
		itemHeld = false
	if(selectedItem != null and Input.is_action_just_pressed("LMB")):
		itemHeld = true
	if(itemHeld == true and selectedItem != null):
		updateItemPos(selectedItem)

func prepAllFoods():
	for i in $foodGroup.get_child_count():
		var foodDeets = randi_range(0,6)
		while(allFoods.has(foodDeets)):
			foodDeets = randi_range(0,6)
		$foodGroup.get_child(i).frame = foodDeets
		allFoods.append(foodDeets)

func prepMenuItems():
	for i in $foodGroup.get_child_count():
		var foodSelect = $foodGroup.get_child(i).get_child(0)
		var food = $foodGroup.get_child(i)

		foodSelect.connect("mouse_entered", _on_select_mouse_entered.bind(food))
		foodSelect.connect("mouse_exited", _on_select_mouse_exit.bind(food))

func on_new_time_timeout(person, bubble, food):
	var foodFrame = generteRandomFood()
	person.scale = Vector2(.2,.75)
	person.frame = 1
	while(chosenFoods.has(foodFrame)):
		foodFrame = generteRandomFood()
	chosenFoods.append(foodFrame)
	food.frame = foodFrame
	food.get_child(0).area_entered.connect(_selected_item_meets_idea_item.bind(food)) #HUH? Why did this suddenly work? DO NOT TOUCH
	food.show()
	bubble.show()

func generteRandomFood():
	return randi_range(0,6)

func _on_select_mouse_entered(food) -> void:
	if(selectedItem == null):
		selectedItem = food

func _on_select_mouse_exit(food):
	if(selectedItem != null and itemHeld == false):
		selectedItem = null

func updateItemPos(item):
	item.global_position = get_local_mouse_position()

func _selected_item_meets_idea_item(foodItem, idea):
	var compare = foodItem.get_parent()
	if(idea.frame == compare.frame):
		var idx = idea.get_index()
		$ideaFood.get_child(idx).hide()
		$peopleGroup.get_child(idx).hide()
		$bubbles.get_child(idx).hide()
		selectedItem = null
		itemHeld = false
		compare.hide()
		peopleServed+=1
		check_people_served()

func check_people_served():
	if(peopleServed == 3):
		PlayerStats.score += 1
		$countDown/ProgressBar.value = PlayerStats.speed
		ScreenBus.inGameNextRand()
